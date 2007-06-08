From: Scott Lamb <slamb@slamb.org>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Fri, 08 Jun 2007 14:31:32 -0700
Message-ID: <4669CAB4.5080507@slamb.org>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com> <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Benjamin Sergeant <bsergean@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 23:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwm3c-0003F7-3u
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 23:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967221AbXFHVbm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 17:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966814AbXFHVbm
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 17:31:42 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:44360 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbXFHVbl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 17:31:41 -0400
Received: from slamb-mac.dhcp.2wire.com (slamb-mac.vpn.slamb.org [172.16.0.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id B0610980D1;
	Fri,  8 Jun 2007 14:31:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49504>

Benjamin Sergeant wrote:
> A perforce command with all the files in the repo is generated to get
> all the file content.
> Here is a patch to break it into multiple successive perforce command
> who uses 4K of parameter max, and collect the output for later.
> 
> It works, but not for big depos, because the whole perforce depo
> content is stored in memory in P4Sync.run(), and it looks like mine is
> bigger than 2 Gigs, so I had to kill the process.

Hmm. I tried git-p4 out on Sunday, and it definitely didn't do this 
then...this commit must have showed up since:

     commit 6460cf12df4556f889888b5f0b49e07040747e6f
     Author: Han-Wen Nienhuys <hanwen@google.com>
     Date:   Wed May 23 18:49:35 2007 -0300

         Read p4 files in one batch.

I believe HEAD at the time was this:

     commit 458e0545cb3dd03af9cd1a61480cbb764639043a
     Author: Simon Hausmann <simon@lst.de>
     Date:   Mon May 28 19:24:57 2007 +0200

         Fix typo in listExistingP4Branches that broke sync.

so you might try checking out an old version, and I'll go RTFM on 
reading merge history, because I can't figure out when this happened.

> 
> 
> diff --git a/git-p4 b/git-p4
> index 36fe69a..906b193 100755
> --- a/git-p4
> +++ b/git-p4
> @@ -703,9 +703,22 @@ class P4Sync(Command):
>         if not files:
>             return
> 
> -        filedata = p4CmdList('print %s' % ' '.join(['"%s#%s"' % 
> (f['path'],
> -                                                                 f['rev'])
> -                                                    for f in files]))
> +        # We cannot put all the files on the command line
> +        # OS have limitations on the max lenght of arguments
> +        # POSIX says it's 4096 bytes, default for Linux seems to be 130 K.
> +        # and all OS from the table below seems to be higher than POSIX.
> +        # See http://www.in-ulm.de/~mascheck/various/argmax/

No need to hardcode - from Python this is 
os.sysconf(os.sysconf_names['SC_ARG_MAX'])

> +        chunk = ''
> +        filedata = []
> +        for i in xrange(len(files)):
> +            f = files[i]
> +            chunk += '"%s#%s" ' % (f['path'], f['rev'])
> +            if len(chunk) > 4000 or i == len(files)-1:
> +                data = p4CmdList('print %s' % chunk)
> +                if "p4ExitCode" in data[0]:
> +                    die("Problems executing p4. Error: [%d]." %
> (data[0]['p4ExitCode']));
> +                filedata.extend(data)
> +                chunk = ''
> 
>         j = 0;
>         contents = {}
> @@ -1486,3 +1499,5 @@ def main():
> 
> if __name__ == '__main__':
>     main()
> +
> +# vim: set filetype=python sts=4 sw=4 et si :
