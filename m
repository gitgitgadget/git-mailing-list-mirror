From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2] git-p4: Ask "p4" to interpret View setting
Date: Thu, 15 Aug 2013 21:24:20 -0400
Message-ID: <20130816012420.GA20985@padd.com>
References: <CACGba4zdA=3tBE9UR=i9P9kNAL1HUc3UwSHbYeq4s9fwaN4=Mw@mail.gmail.com>
 <20130810201123.GA31706@padd.com>
 <CACGba4wbqyHzXDCQxG31EKawfc-D4jpVYqbB4GdmK4hM=Oi4mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kazuki saitoh <ksaitoh560@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 03:24:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA8mD-0001fR-Ar
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 03:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab3HPBYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 21:24:25 -0400
Received: from honk.padd.com ([74.3.171.149]:40816 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338Ab3HPBYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 21:24:24 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id 325955B1F;
	Thu, 15 Aug 2013 18:24:23 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 88A89227BB; Thu, 15 Aug 2013 21:24:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CACGba4wbqyHzXDCQxG31EKawfc-D4jpVYqbB4GdmK4hM=Oi4mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232390>

ksaitoh560@gmail.com wrote on Wed, 14 Aug 2013 09:59 +0900:
> > My only concern is in the commit message, about performance.  A
> > change that has lots of files in it will cause many roundtrips to
> > p4d to do "p4 where" on each.  When the files don't have much
> > edited content, this new approach will make the import take twice
> > as long, I'll guess.  Do you have a big repository where you
> > could test that?
> 
> I measured performance of "git p4 clone  --use-client-spec" with a
> repository it has 1925 files, 50MB.
>   Original:    8.05s user 32.02s system 15% cpu 4:25.34 total
>   Apply patch:    9.02s user 53.19s system 14% cpu 6:56.41 total
> 
> It is acceptable in my situation, but looks quite slow...
> 
> Then I implemented one batch query version
>    7.92s user 33.03s system 15% cpu 4:25.59 total
> 
> It is same as original
> 
> My additional patch is below.
> I investigate call graph (attached rough sketch) and
> implement batch query in "commit()" and "splitFilesIntoBranches()".
> In addition, modified "map_in_client" to just search cache value.
> 
> Could you accept?

This looks good.  I've started my own performance testing
on a few-hundred-thousand file repo to confirm your findings.

If it seems to work out, we can clean up the patch.  Otherwise
maybe need to think about having both implementations and use
the by-hand one for "...".  I don't like that approach.  Let's
hope it's not needed.

		-- Pete

> Subject: [PATCH] git p4: Implement as one batch "p4 where" query to interpret
>  view spec
> 
> Query for each file is decrese performance.
> So I implement query to get client file path as one batch query.
> The query must called before use client path (map_in_client() ).
> 
> Result of performance measurement, about 40% speed up
> 
> Signed-off-by: KazukiSaitoh <ksaitoh560@gmail.com>
> ---
>  git-p4.py | 70 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 19 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index 40522f7..8cbee24 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1849,37 +1849,46 @@ class View(object):
>          if not exclude:
>              self.mappings.append(depot_side)
> 
> -    def map_in_client(self, depot_path):
> -        """Return the relative location in the client where this
> -           depot file should live.  Returns "" if the file should
> -           not be mapped in the client."""
> +    def convert_client_path(self, clientFile):
> +        # chop off //client/ part to make it relative
> +        if not clientFile.startswith(self.client_prefix):
> +            die("No prefix '%s' on clientFile '%s'" %
> +                (self.client_prefix, clientFile))
> +        return clientFile[len(self.client_prefix):]
> 
> -        if depot_path in self.client_spec_path_cache:
> -            return self.client_spec_path_cache[depot_path]
> +    def update_client_spec_path_cache(self, files):
> +        fileArgs = [f for f in files if f not in self.client_spec_path_cache]
> 
> -        where_result = p4CmdList(['where', depot_path])
> -        if len(where_result) == 0:
> -            die("No result from 'p4 where %s'" % depot_path)
> -        client_path = ""
> +        if len(fileArgs) == 0:
> +            return  # All files in cache
> +
> +        where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs)
>          for res in where_result:
>              if "code" in res and res["code"] == "error":
>                  # assume error is "... file(s) not in client view"
> -                client_path = ""
>                  continue
>              if "clientFile" not in res:
>                  die("No clientFile from 'p4 where %s'" % depot_path)
>              if "unmap" in res:
>                  # it will list all of them, but only one not unmap-ped
>                  continue
> -            # chop off //client/ part to make it relative
> -            clientFile = res["clientFile"]
> -            if not clientFile.startswith(self.client_prefix):
> -                die("No prefix '%s' on clientFile '%s'" %
> -                    (self.client_prefix, clientFile))
> -            client_path = clientFile[len(self.client_prefix):]
> +            self.client_spec_path_cache[res['depotFile']] =
> self.convert_client_path(res["clientFile"])
> +
> +        # not found files or unmap files set to ""
> +        for depotFile in fileArgs:
> +            if depotFile not in self.client_spec_path_cache:
> +                self.client_spec_path_cache[depotFile] = ""
> +
> +    def map_in_client(self, depot_path):
> +        """Return the relative location in the client where this
> +           depot file should live.  Returns "" if the file should
> +           not be mapped in the client."""
> +
> +        if depot_path in self.client_spec_path_cache:
> +            return self.client_spec_path_cache[depot_path]
> 
> -        self.client_spec_path_cache[depot_path] = client_path
> -        return client_path
> +        die( "Error: %s is not found in client spec path" % depot_path )
> +        return ""
> 
>  class P4Sync(Command, P4UserMap):
>      delete_actions = ( "delete", "move/delete", "purge" )
> @@ -2006,6 +2015,22 @@ class P4Sync(Command, P4UserMap):
>          """Look at each depotFile in the commit to figure out to what
>             branch it belongs."""
> 
> +        # create file list and get client paths by one batch "p4 where" query
> +        if self.clientSpecDirs:
> +            fnum = 0
> +            file_list  = []
> +            while commit.has_key("depotFile%s" % fnum):
> +                path =  commit["depotFile%s" % fnum]
> +                found = [p for p in self.depotPaths
> +                         if p4PathStartsWith(path, p)]
> +                if not found:
> +                    fnum = fnum + 1
> +                    continue
> +
> +                file_list.append(path)
> +                fnum = fnum + 1
> +            self.clientSpecDirs.update_client_spec_path_cache(file_list)
> +
>          branches = {}
>          fnum = 0
>          while commit.has_key("depotFile%s" % fnum):
> @@ -2255,6 +2280,13 @@ class P4Sync(Command, P4UserMap):
>              else:
>                  sys.stderr.write("Ignoring file outside of prefix:
> %s\n" % f['path'])
> 
> +        # get client paths by one batch "p4 where" query
> +        if self.clientSpecDirs:
> +            file_list = []
> +            for f in files:
> +                file_list.append(f['path'])
> +            self.clientSpecDirs.update_client_spec_path_cache(file_list)
> +
>          self.gitStream.write("commit %s\n" % branch)
>  #        gitStream.write("mark :%s\n" % details["change"])
>          self.committedChanges.add(int(details["change"]))
> -- 
> 1.8.4-rc2
