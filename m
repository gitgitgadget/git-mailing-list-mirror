From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/5] git-p4: add support for large file systems
Date: Wed, 09 Sep 2015 10:20:01 -0700
Message-ID: <xmqq37yn7bni.fsf@gitster.mtv.corp.google.com>
References: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
	<1441799950-54633-5-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 09 19:20:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZj2t-0001Zy-09
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 19:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbbIIRUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 13:20:07 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36706 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbbIIRUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 13:20:06 -0400
Received: by padhk3 with SMTP id hk3so15852067pad.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JE+DS1kkqFUCUSv1xW77KgF1KtgHd/3LirP+125x/gE=;
        b=bGixRnAKJoC+beEOjft2V4xi6g19+QikS1W+Bm9HiWOSt1TgAyzzypsJLlYZWvXfbv
         LdpCN2Xl4CSdUNvjiDIhmDv2KjvJ1nrHC67lGCzU1PxtIY+fe+S9E1rQZ8Y+5hDALjFo
         Eb78OmWVyJbv/qcqP3aVVXR134O+j13C7hcD24u4QMdNjRn7m6+QFiMns+aypQX+jSmP
         1B/cZzP76OB25eu/x6odDg0XBe8hBFn78ISrXgvit6jdNzWrBCIbarTJuZ4YKIVmf7RQ
         V4Xg9W0v4s+Teys2axcoWgO5zCu/xHmhX9gwm/mJ+BsNVin/DmZsFwLCyM3W70zwH+Vh
         yqPQ==
X-Received: by 10.68.230.33 with SMTP id sv1mr73924985pbc.160.1441819204951;
        Wed, 09 Sep 2015 10:20:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:31c8:2790:408d:8446])
        by smtp.gmail.com with ESMTPSA id yi8sm7666807pab.22.2015.09.09.10.20.02
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 09 Sep 2015 10:20:02 -0700 (PDT)
In-Reply-To: <1441799950-54633-5-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 9 Sep 2015 13:59:09
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277559>

larsxschneider@gmail.com writes:

> @@ -2226,17 +2355,16 @@ class P4Sync(Command, P4UserMap):
>              text = regexp.sub(r'$\1$', text)
>              contents = [ text ]
>  
> -        self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
> +        if relPath == '.gitattributes':
> +            die('.gitattributes already exists in P4.')

This looks like an unfortunate limitation to me.

Is it really necessary that you need to reject unrelated attributes
the user has (presumably for a good reason)?  It seems to me that
you only need to _add_ entries to make file extension based decision
to send paths selectively to LFS?

Also the exact format of these attributes entries looks like very
closely tied to GitHub LFS and not generic (for example, there is no
reason to expect that any large-file support would always use the
"filter" mechanism or the gitattributes mechanism for that
matter), ...

+    def writeGitAttributesToStream(self):
+        self.writeToGitStream(
+            '100644',
+            '.gitattributes',
+            [
+                '\n',
+                '#\n',
+                '# %s\n' % largeFileSystem().attributeDescription(),
+                '#\n',
+            ] +
+            ['*.' + f.replace(' ', '[:space:]') + ' filter=%s -text\n'
+                % largeFileSystem().attributeFilter()
+                for f in sorted(gitConfigList("git-p4.largeFileExtensions"))
+            ] +
+            ['/' + f.replace(' ', '[:space:]') + ' filter=%s -text\n'
+                % largeFileSystem().attributeFilter()
+                for f in sorted(self.largeFiles) if not self.hasLargeFileExtension(f)
+            ]
+        )
+

... so while I can see the code like the above needs to exist
somewhere in "git p4" to support GitHub LFS, I am not sure if it
belongs to the generic part of the code.  For the same reason, I do
not know if these replacements with largeFileSystem().getters() are
really adding much value.

How is collaboration between those who talk to the same p4 depot
backed by GitHub LFS expected to work?  You use config to set size
limits and list of file extensions in your repository, and grab new
changes from p4 and turn them into Git commits (with pointers to LFS
and the .gitattributes file that records your choice of the config).
I as a new member to the same project come, clone the resulting Git
repository from you and then what do I do before talking to the same
p4 depot to further update the Git history?  Are the values recorded
in .gitattributes (which essentially were derived from your
configuration) somehow reflected back automatically to my config so
that our world view would become consistent?  Perhaps you added
'iso' to largeFileExtensions before I cloned from you, and that
would be present in the copy of .gitattributes I obtained from you.
I may be trying to add a new ".iso" file, and I presume that an
existing .gitattributes entry you created based on the file
extension automatically covers it from the LFS side, but does my
"git p4 submit" also know what to do, or would it be broken until I
add a set of configrations that matches yours?
