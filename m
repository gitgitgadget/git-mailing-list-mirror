From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Stats in Git
Date: Sun, 02 Sep 2007 16:49:55 +0200
Message-ID: <46DACD93.9000509@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 16:50:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRqmA-0001yK-FR
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 16:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612AbXIBOuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 10:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756055AbXIBOuE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 10:50:04 -0400
Received: from esparsett.troll.no ([62.70.27.18]:55910 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211AbXIBOuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 10:50:01 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id A14EB7421B; Sun,  2 Sep 2007 16:49:59 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id 7A94B7421A; Sun,  2 Sep 2007 16:49:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.3
OpenPGP: id=34EB4437
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57333>

I was checking out the performance situation with Git on Windows, and
found out that the Posix stat functions on Windows are just obscenely
slow. We really can't use them, at least on in Git. So, I made a patch
for the MinGW version, which I'll post right after this mail.

However, while look at that whole stat'ing situation in git, I saw
that doing 'git status' actually stats all the files _thrice_!
Yup, that's not 1 time, or 2 times, but actually 3(!) times before
'git status' is content!
I know that git-status is a script, so I think this clearly indicates
that git-status is a prime candidate for a built-in ;-)

I haven't looked into details as to why it stats the files so many
times. I guess someone more experienced in Git core could give an
opinion, if by writing git-status as a builtin it would be possible to
only stat the files once. It would have a huge impact on Windows where
stats are inheritly much slower than on Linux.

By applying the diff below, you can see for yourself what happens when
you stat the repo created with Moe's script:
    mkdir bummer
    cd bummer
    for ((i=0;i<100;i++)); do
    mkdir $i && pushd $i;
    for ((j=0;j<1000;j++)); do
    echo "$j" >$j; done; popd;
    done

$ git status 2>&1 | wc -l
300137

Fast on Linux now, but still quite slow on Windows..

--
.marius


diff --git a/git-compat-util.h b/git-compat-util.h
index ca0a597..6b6405c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -369,4 +369,23 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 	return 0;
 }

+static inline int git_lstat(const char *file_name, struct stat *buf)
+{
+	fprintf(stderr, "lstat: %s\n", file_name);
+	return lstat(file_name, buf);
+}
+static inline int git_fstat(int fd, struct stat *buf)
+{
+	fprintf(stderr, "fstat: %d\n", fd);
+	return fstat(fd, buf);
+}
+static inline int git_stat(const char *file_name, struct stat *buf)
+{
+	fprintf(stderr, "stat: %s\n", file_name);
+	return stat(file_name, buf);
+}
+#define lstat(x,y) git_lstat(x,y)
+#define fstat(x,y) git_fstat(x,y)
+#define stat(x,y) git_stat(x,y)
+
 #endif
