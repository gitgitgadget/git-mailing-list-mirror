From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Possible bug: "git log" ignores "--encoding=UTF-8" option if --pretty=format:%e%n%s%n is used
Date: Tue, 11 Nov 2008 22:12:46 +0300
Message-ID: <85647ef50811111112o5449c12elfc571e46e607cfd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 20:14:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzygk-00006R-Fa
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 20:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbYKKTMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 14:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbYKKTMt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 14:12:49 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:59239 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbYKKTMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 14:12:48 -0500
Received: by fk-out-0910.google.com with SMTP id 18so33611fkq.5
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 11:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Kh85jjEav44DWRvc7Y6GT+Qt2OyyTYQ0Fa2rqxBv8FQ=;
        b=kYHQuA9gwL91Ksa62TrDm3APeLRtO3LewIXtTNPUOxQ5HrB3j067PRpYTGlmFG/uvE
         0ZBUD/awVxvizjt7b86qIHP3KUw4F56sqatN1TO7G/Lg+UBjAQiADhD1rsSkOouwOL7o
         GOxWi8O4H5T7lcQGM/SgVn1Ezcjd3T9m7+zzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=HMH1PnER/94ygkuk3DmN6xkzwtWdvCknpr93+ZlWbPDapeJgFxvpR+kMrpPQXsYSeV
         0mnoGR8V42Vxg9u4VAG11Ih7tO6SJZwOgxpom4CO8/SLvJcLS5FZDqa8vx5QxRuAE+C3
         XWQJjPF3jd53L4hsvROcZxh/pH3a66wUlibtA=
Received: by 10.181.208.11 with SMTP id k11mr2590751bkq.180.1226430766140;
        Tue, 11 Nov 2008 11:12:46 -0800 (PST)
Received: by 10.180.230.10 with HTTP; Tue, 11 Nov 2008 11:12:46 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100670>

If encoding is forced for git log with "--encoding=UTF-8", it seems to
be ineffective for the formatted output. Is it intentional?

Lets consider the following scenario (script is for bash, git 1.5.4.3
and 1.6.0.2):

git init
echo initial >test.txt
git add test.txt
echo -e \\0320\\0242\\0320\\0265\\0321\\0201\\0321\\0202 >msg-UTF-8.txt
git commit -F msg-UTF-8.txt
echo updated >test.txt
git add test.txt
echo -e \\0322\\0345\\0361\\0362 >msg-windows-1251.txt
git config i18n.commitencoding Windows-1251
git commit -F msg-windows-1251.txt
git log --encoding=Windows-1251 >log1.txt
git log --encoding=UTF-8 >log2.txt
git log --encoding=Windows-1251 --pretty=format:%e%n%s%n >log3.txt
git log --encoding=UTF-8 --pretty=format:%e%n%s%n >log4.txt

In the both cases the string is the russian string meaning test in
different encoding.

If we compare log1.txt and log2.txt, we will see that the same
encoding specified is used for both commits in the log.

If we compare log3.txt and log4.txt, we will see that the same the
contents of the file is completely identical. The native encoding is
used for each commit. So the first listed commit
is encoded using Windows-1251 and the second one using UTF-8. However
in the description of the %s %b options nothing is said about which
encoding is used and implied behavior is that they are affected by
--encoding option.

I suggest documenting that the placeholders %s and %b use native
commit encoding and introducing the placeholders %S and %B options
that use encoding specified on the command line or the default log
encoding.

I also suggest adding %g and %G placeholders (%m placeholder is
already occupied) that print the entire commit message instead of just
the subject or the body. Currently the tools have to join the entire
message from two parts when they are just interested in the entire
message.

Regards,
Constantine
