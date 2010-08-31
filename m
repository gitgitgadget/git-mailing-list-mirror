From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP files.
Date: Tue, 31 Aug 2010 17:06:50 -0400
Message-ID: <AANLkTimiSBjifxtDoFXAEAEpYM8bJ18SwJ5Fj8zqh_G6@mail.gmail.com>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
	<4C7B8E1E.6050708@drmicha.warpmail.net>
	<AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
	<20100830141602.GF2315@burratino>
	<AANLkTim+S87KjFBstBineR02hQHzG=X2VDqgiGNbPQGS@mail.gmail.com>
	<20100830163302.GA13336@burratino>
	<AANLkTi=VPf9CWNJcce6d20HQChi0mHgTG1F=jakzNT-O@mail.gmail.com>
	<4C7C020C.6090907@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 23:06:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqY2j-0007JP-CG
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 23:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab0HaVGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 17:06:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58504 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab0HaVGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 17:06:52 -0400
Received: by bwz11 with SMTP id 11so4816106bwz.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+d3md8EhkmUAwrdffRpnca82fpQCkJ8yiqjG0f+9ZUA=;
        b=djpOlKBz3+EK+hRRDKc20HESILjMEkrjTPsFc+D18g4I+J/fEwdzsGx5UPQmfAOhL+
         U548maYA1PkpA7sSsEvcwwcgggkiwXFzEnnNzSgXdzRsQa1d6y0O9x658cCa0lkOS6e6
         q+5Crr2naC7K3TqPQ4EYghfle3YiE+iDiZDms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aHJtP7uoM9q1eBKfTBXgXdHdTL7e3p4rWgiqOnPz9rqs6iAuQOIvljOQ5UYpDt9qg6
         pMPLGAl1X5f426vRo2e3A3SJoW+HBhyf1qYdl2wr/J6pL3C5t4d1DYw11tkXbcbxawUo
         UNLvQYRwXfDfSfI/GSIh4EfFDURFqI4S/dKZc=
Received: by 10.204.6.75 with SMTP id 11mr4892316bky.95.1283288810573; Tue, 31
 Aug 2010 14:06:50 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Tue, 31 Aug 2010 14:06:50 -0700 (PDT)
In-Reply-To: <4C7C020C.6090907@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154982>

On Mon, Aug 30, 2010 at 3:10 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> git diff-tree --root $newrev
>
> will take care of this.
>
> Michael
>

Thank you sir! You are a scholar and a gentleman, and I sincerely
appreciate the help.

Here is the completed hook for anyone who is curious, this turned into
a more complex project than I thought it would be, but I learned a
heck of a lot along the way so that's a good thing!

-Chris
----
#!/home/php/bin/php
<?php

function parseHookInput() {
        $fpstdin = fopen("php://stdin","r");

        $line = fgets($fpstdin);

        list($old_sha1,$new_sha1,$refname)=explode(" ",$line);

        #echo "ns: $new_sha1\n";
        #echo "os: $old_sha1\n";
        #echo "refname: $refname\n";
        return array($old_sha1,$new_sha1);
}

function detectNewBranch($old_sha1,$new_sha1) {
        if ($old_sha1 == "0000000000000000000000000000000000000000") {
                return true;
        }
        else {
                return false;
        }
}


function parseDiff($old_sha1,$new_sha1,$diffcmd,$regex) {
        $diff = array();

        exec($diffcmd,$diff,$diffrcval);
        if ($diffrcval != 0) {
                echo "Syntax checker hook is malfunctioning.  Can't
execute git ls-tree.  Failing gracefully and allowing this push.\n";
                exit(0);
        }
        # If we can execute the git diff I'm assuming we have access
to a working git.

        foreach ($diff as &$diffline) {
                preg_match($regex,$diffline,$matches);
                $blob = $matches[1];
                $filename = $matches[2];
                #echo "Blob: $blob Filename: $filename\n";
                SyntaxCheckFile($blob,$filename);
        }
}

function syntaxCheckFile($blob,$filename) {
        $needle = '/(\.php|\.module|\.install)$/';
        if (preg_match($needle,$filename)) {
                #echo "Checking $filename\n";
                $dummy = array();
                exec("git show $blob|/home/php/bin/php -l",$dummy,$checkrcval);
                if ($checkrcval != 0) {
                        echo "There was a syntax error in '$filename'.
 Rejecting this attempted merge!\n";
                        exit(1);
                }
        }
}

function parseCommit($old_sha1,$new_sha1) {
        # if this is the first commit on a new branch, $old_sha1 will
be a bunch of zeroes, and so
        # git diff --raw will fail, since there's no old ref to
compare against.  So, we parse the
        # results of git diff-tree -root=$new_sha1 instead to get the
blob and filename we'll need.
        if (detectNewBranch($old_sha1,$new_sha1)) {
                $diffcmd="git diff-tree --root $new_sha1";
                $regex="/\:\w+ \w+ \w+ (\w+) \w (.+)/";
        }
        else {
                $diffcmd="git diff --raw $old_sha1 $new_sha1";
                $regex="/\:\d+ \d+ \w+... (\w+)... \w\t(.+)/";
        }
        parseDiff($old_sha1,$new_sha1,$diffcmd,$regex);
}

# End function definitions.  Main code body starts here.

# This pre-receive git hook gets passed the ref before the push, and
the ref that would be
# created if the push succeeds.
list($old_sha1,$new_sha1) = parseHookInput();

parseCommit($old_sha1,$new_sha1);

exit(0);



-- 
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, Pixar
