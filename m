From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Support different branch layouts in git-p4
Date: Thu, 10 Feb 2011 08:43:06 -0500
Message-ID: <20110210134306.GA4078@arf.padd.com>
References: <4D489068.2040704@vmware.com>
 <AANLkTi=ozDk9SqYaYWKHXSjVChV-93-88F_LUCwfSiDc@mail.gmail.com>
 <4D4F3738.7010603@vmware.com>
 <AANLkTimGKc4MTwb=AnZ_Bv1EGS7yfgrFupxBOVVSm4s8@mail.gmail.com>
 <4D520E2B.2080200@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Ian Wienand <ianw@vmware.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 14:43:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnWnk-00061e-PE
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 14:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab1BJNnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 08:43:11 -0500
Received: from honk.padd.com ([74.3.171.149]:51534 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126Ab1BJNnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 08:43:09 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 9C4E8BC;
	Thu, 10 Feb 2011 05:43:08 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4F0C731ADE; Thu, 10 Feb 2011 08:43:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4D520E2B.2080200@vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166483>

ianw@vmware.com wrote on Tue, 08 Feb 2011 19:46 -0800:
> So here's another version; I agree some testing would be good as I've
> only run it locally on //depot/proj/branch clients

This is good.  Thanks for fixing it up.  One last pedantic whine
from me.  Fix the regex for the error case:

    arf$ python
    >>> import re
    >>> re.match('\%\%d', "%%3")
    >>> re.match(r'%%\d', "%%3")
    >>> <_sre.SRE_Match object at 0x1ec4168>


		-- Pete

> ---
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 04ce7e3..3304f36 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -910,6 +910,22 @@ class P4Sync(Command):
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
> +
>          if self.keepRepoPath:
>              prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
>  
> @@ -1032,7 +1048,7 @@ class P4Sync(Command):
>              includeFile = True
>              for val in self.clientSpecDirs:
>                  if f['path'].startswith(val[0]):
> -                    if val[1] <= 0:
> +                    if val[1][0] <= 0:
>                          includeFile = False
>                      break
>  
> @@ -1475,19 +1491,45 @@ class P4Sync(Command):
>          for entry in specList:
>              for k,v in entry.iteritems():
>                  if k.startswith("View"):
> +
> +                    # p4 has these %%1 to %%9 arguments in specs to
> +                    # reorder paths; which we can't handle (yet :)
> +                    if re.match('\%\%d', v) != None:
> +                        print "Sorry, can't handle %%n arguments in client specs"
> +                        sys.exit(1)
> +
>                      if v.startswith('"'):
>                          start = 1
>                      else:
>                          start = 0
>                      index = v.find("...")
> +
> +                    # save the "client view"; i.e the RHS of the view
> +                    # line that tells the client where to put the
> +                    # files for this view.
> +                    cv = v[index+3:].strip() # +3 to remove previous '...'
> +
> +                    # if the client view doesn't end with a
> +                    # ... wildcard, then we're going to mess up the
> +                    # output directory, so fail gracefully.
> +                    if not cv.endswith('...'):
> +                        print 'Sorry, client view in "%s" needs to end with wildcard' % (k)
> +                        sys.exit(1)
> +                    cv=cv[:-3]
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
>  
>      def run(self, args):
>          self.depotPaths = []
> diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
> index 49b3359..e09da44 100644
> --- a/contrib/fast-import/git-p4.txt
> +++ b/contrib/fast-import/git-p4.txt
> @@ -191,6 +191,11 @@ git-p4.useclientspec
>  
>    git config [--global] git-p4.useclientspec false
>  
> +The P4CLIENT environment variable should be correctly set for p4 to be
> +able to find the relevant client.  This client spec will be used to
> +both filter the files cloned by git and set the directory layout as
> +specified in the client (this implies --keep-path style semantics).
> +
>  Implementation Details...
>  =========================
>  
> 
