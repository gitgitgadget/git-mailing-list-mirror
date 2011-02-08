From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Support different branch layouts in git-p4
Date: Mon, 7 Feb 2011 20:22:08 -0500
Message-ID: <20110208012208.GA28329@arf.padd.com>
References: <4D489068.2040704@vmware.com>
 <AANLkTi=ozDk9SqYaYWKHXSjVChV-93-88F_LUCwfSiDc@mail.gmail.com>
 <4D4F3738.7010603@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Ian Wienand <ianw@vmware.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 02:22:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmcHf-00054v-6P
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 02:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab1BHBWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 20:22:17 -0500
Received: from honk.padd.com ([74.3.171.149]:53462 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594Ab1BHBWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 20:22:17 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 5B624EF;
	Mon,  7 Feb 2011 17:22:15 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8B6BF31ADE; Mon,  7 Feb 2011 20:22:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4D4F3738.7010603@vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166325>

ianw@vmware.com wrote on Sun, 06 Feb 2011 16:05 -0800:
> I did consider this at first.  My only issue is that it is a bit
> confusing to use the client spec for filtering (and in this case
> re-writing), but not for actually selecting the depots to clone, which
> I still need to replicate on the command line.  However that is a much
> larger change.
> 
> What do you think of this one?
> 
> In this case, my client view is
> 
> //depot/project/branch/...  //client/branch/project/...
> //depot/project2/branch/...  //client/branch/project2/...
> 
> and my git directory layout ends up as
> 
> branch/project/...
> branch/project2/...

We had such terrible p4 mappings too, before the last
rearrangement put us into a single-line view spec.  I think
it would help others to include such support, though.

Back then, I hacked together similar code to deal with the
annoyance.  My code was not pretty and not complete, either.

If you look at "p4 help views", they have lots of oddities
that in theory should be accounted for here.  It doesn't
even mention the thing about quotes, but obviously that is
supported.  Wildcards ... and * can appear multiple
times.  And %%[1-9] can be used to reorder the path.  Also the
order of lines matters, and "+" can be used to merge entries.
Whew.

In practice, I think you get most everything we care about.  A
few comments below, beyond the bits that Tor Arvid caught.

		-- Pete

> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 04ce7e3..eb9620c 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -878,6 +878,7 @@ class P4Sync(Command):
>          self.cloneExclude = []
>          self.useClientSpec = False
>          self.clientSpecDirs = []
> +        self.clientName = None

Unused.

>          if gitConfig("git-p4.syncFromOrigin") == "false":
>              self.syncWithOrigin = False
> @@ -910,6 +911,22 @@ class P4Sync(Command):
>          return files
>  
>      def stripRepoPath(self, path, prefixes):
> +        if self.useClientSpec:
> +
> +            # if using the client spec, we use the output directory
> +            # specified in the client.  For example, a view
> +            #   //depot/foo/branch/... //client/branch/foo/...
> +            # will end up putting all foo/branch files into
> +            #  branch/foo/
> +            for val in self.clientSpecDirs:
> +                if path.startswith(val[0]):
> +                    # replace the depot path with the client path
> +                    path = path.replace(val[0], val[1][1])
> +                    # now strip out the client (//client/...)
> +                    path = re.sub("^(//[^/]+/)", '', path)
> +                    # the rest is all path
> +                    return path

That's clever.  Better than having to remember Client: and build
//client/ out of it.  You could do this down in getClientSpec()
so that val[1] starts with the git-relative path.

>          if self.keepRepoPath:
>              prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
>  
> @@ -1032,7 +1049,7 @@ class P4Sync(Command):
>              includeFile = True
>              for val in self.clientSpecDirs:
>                  if f['path'].startswith(val[0]):
> -                    if val[1] <= 0:
> +                    if val[1][0] <= 0:
>                          includeFile = False
>                      break
>  
> @@ -1474,20 +1491,36 @@ class P4Sync(Command):
>          temp = {}
>          for entry in specList:
>              for k,v in entry.iteritems():
> +                if k.startswith("Client"):
> +                    self.clientName = v

Oh maybe here is where you thought you would need client, but
don't.

>                  if k.startswith("View"):
>                      if v.startswith('"'):
>                          start = 1
>                      else:
>                          start = 0
>                      index = v.find("...")
> +
> +                    # save the "client view"; i.e the RHS of the view
> +                    # line that tells the client where to put the
> +                    # files for this view.
> +                    cv = v[index+4:] # +4 to remove previous '... '
> +                    cv_index = cv.find("...")
> +                    cv=cv[:cv_index]
> +
> +                    # now save the view; +index means included, -index
> +                    # means it should be filtered out.
>                      v = v[start:index]
>                      if v.startswith("-"):
>                          v = v[1:]
> -                        temp[v] = -len(v)
> +                        include = -len(v)
>                      else:
> -                        temp[v] = len(v)
> +                        include = len(v)
> +
> +                    temp[v] = (include, cv)
> +
>          self.clientSpecDirs = temp.items()
> -        self.clientSpecDirs.sort( lambda x, y: abs( y[1] ) - abs( x[1] ) )
> +        self.clientSpecDirs.sort( lambda x, y: abs( y[1][0] ) - abs( x[1][0] ) )
