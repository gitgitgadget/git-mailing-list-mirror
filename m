From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/2] git-p4: Improve rename detection support.
Date: Sat, 5 Feb 2011 19:21:13 -0500
Message-ID: <20110206002113.GA31245@arf.padd.com>
References: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 01:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlsNl-0003Gm-2a
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 01:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab1BFAVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 19:21:32 -0500
Received: from honk.padd.com ([74.3.171.149]:48381 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab1BFAVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 19:21:32 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id B7E3D2E8;
	Sat,  5 Feb 2011 16:21:30 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E58C431ADE; Sat,  5 Feb 2011 19:21:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166133>

vitor.hda@gmail.com wrote on Sun, 30 Jan 2011 23:19 +0000:
> Only open files for edit after integrating if the SHA1 of source and destination
> differ from each other.
> Add git config option detectRenames to allow permanent rename detection. This
> options should be set to a true/false value.

I like the idea.

>      def applyCommit(self, id):
>          print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
> -        diffOpts = ("", "-M")[self.detectRename]
> +
> +        detectRenames = gitConfig("git-p4.detectRenames")
> +        if len(detectRenames) and detectRenames.lower() != "false" > 0:
> +            diffOpts = "-M"
> +        else:
> +            diffOpts = ("", "-M")[self.detectRename]

The comparisons confuse me.  detectRenames != "false" > 0  ?
How about just detectRenames == "true"?

You could rename the existing self.detectRename to add an "s" so
it all makes a bit more sense.

    if not self.detectRenames:
	# not explicitly set, check the config variable
	b = gitConfig("git-p4.detectRenames")
	if b == "true":
	    self.detectRenames = "-M"

    if self.detectRenames:
	diffOpts = "-M"
    else:
	diffOpts = ""

>          diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
>          filesToAdd = set()
>          filesToDelete = set()
> @@ -640,7 +646,8 @@ class P4Submit(Command):
>              elif modifier == "R":
>                  src, dest = diff['src'], diff['dst']
>                  p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
> -                p4_system("edit \"%s\"" % (dest))
> +                if diff['src_sha1'] != diff['dst_sha1']:
> +                    p4_system("edit \"%s\"" % (dest))
>                  if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
>                      filesToChangeExecBit[dest] = diff['dst_mode']
>                  os.unlink(dest)

If you rename the file and also cause its perms to change (say
add +x), does it still work if dest is not open?

		-- Pete
