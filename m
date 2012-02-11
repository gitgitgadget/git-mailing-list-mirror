From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC/PATCHv2 2/2] git-p4: initial demonstration of possible RCS
 keyword fixup
Date: Sat, 11 Feb 2012 18:42:48 -0500
Message-ID: <20120211234248.GA16691@padd.com>
References: <1328829442-12550-1-git-send-email-luke@diamand.org>
 <1328829442-12550-3-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Scouten <eric@scouten.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Feb 12 00:42:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwMan-0008Jw-5T
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 00:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab2BKXmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 18:42:52 -0500
Received: from honk.padd.com ([74.3.171.149]:45029 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755038Ab2BKXmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 18:42:52 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 1B253E8B;
	Sat, 11 Feb 2012 15:42:51 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6E4D15EC5E; Sat, 11 Feb 2012 18:42:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1328829442-12550-3-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190543>

luke@diamand.org wrote on Thu, 09 Feb 2012 23:17 +0000:
> This change has a go at showing a possible way to fixup RCS
> keyword handling in git-p4.
> 
> It does not cope with deleted files.
> It does not have good test coverage.
> It does not solve the problem of the incorrect error messages.
> But it does at least work after a fashion, and could provide
> a starting point.

I think this has great promise.  Since p4 can always be trusted
to regenerate the keywords, we should be able to scrub them off
at will.

I'm debating whether it's best just _always_ to scrub the files
affected by a diff rather than trying the patch, checking for
failure, then scrubbing and trying again.

I'll send along a bunch of test cases I wrote to play around
with this.  Your case had too many moving parts for me to
understand.  If there's something in there that isn't covered,
maybe you can factor it out into something small?  Feel free
to merge any of my code in with a future resubmission.

Some comments in this code below:

> @@ -753,6 +753,23 @@ class P4Submit(Command, P4UserMap):
>  
>          return result
>  
> +    def patchRCSKeywords(self, file):
> +        # Attempt to zap the RCS keywords in a p4 controlled file
> +        p4_edit(file)
> +        (handle, outFileName) = tempfile.mkstemp()
> +        outFile = os.fdopen(handle, "w+")
> +        inFile = open(file, "r")
> +        for line in inFile.readlines():
> +            line = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)[^$]*\$',

> +                   r'$\1$', line)

I added a couple test cases that show how text+k, text+ko and
everything else need to be handled differently.

> +            outFile.write(line)
> +        inFile.close()
> +        outFile.close()
> +        # Forcibly overwrite the original file
> +        system("cat %s" % outFileName)
> +        system(["mv", "-f", outFileName, file])

Will need a good bit of error handling in the final version.  I
like the way you do it a line at a time, avoiding any issues with
gigantic files.

> @@ -964,9 +982,30 @@ class P4Submit(Command, P4UserMap):
>          patchcmd = diffcmd + " | git apply "
>          tryPatchCmd = patchcmd + "--check -"
>          applyPatchCmd = patchcmd + "--check --apply -"
> +        patch_succeeded = True
>  
>          if os.system(tryPatchCmd) != 0:
> +            fixed_rcs_keywords = False
> +            patch_succeeded = False
>              print "Unfortunately applying the change failed!"
> +
> +            # Patch failed, maybe it's just RCS keyword woes. Look through
> +            # the patch to see if that's possible.
> +            if gitConfig("git-p4.attemptRCSCleanup","--bool") == "true":
> +                file = None
> +                for line in read_pipe_lines(diffcmd):
> +                    m = re.match(r'^diff --git a/(.*)\s+b/(.*)', line)
> +                    if m:
> +                        file = m.group(1)
> +                    if re.match(r'.*\$(Id|Header|Author|Date|DateTime|Change|File|Revision)[^$]*\$', line):
> +                        self.patchRCSKeywords(file)
> +                        fixed_rcs_keywords = True

This is a novel approach too.  Instead of just guessing that
keywords are causing the conflict, inspect the diff for context
or edited lines containing keywords.

Or we could just always scrub every file before even trying to
apply patches.

> +            if fixed_rcs_keywords:
> +                print "Retrying the patch with RCS keywords cleaned up"
> +                if os.system(tryPatchCmd) == 0:
> +                    patch_succeeded = True
> +
> +        if not patch_succeeded:
>              print "What do you want to do?"
>              response = "x"
>              while response != "s" and response != "a" and response != "w":
> @@ -1588,11 +1627,11 @@ class P4Sync(Command, P4UserMap):
>          if type_base in ("text", "unicode", "binary"):
>              if "ko" in type_mods:
>                  text = ''.join(contents)
> -                text = re.sub(r'\$(Id|Header):[^$]*\$', r'$\1$', text)
> +                text = re.sub(r'\$(Id|Header)[^$]*\$', r'$\1$', text)

In a few spots I see you've taken the ":" out of the regex.  This
will match strings like $Idiot$ that shouldn't be keyword
expanded.

Impressed.

		-- Pete
