From: Robert Watson <robert.oo.watson@gmail.com>
Subject: minor problems in git.c
Date: Thu, 1 Dec 2005 12:00:54 +0000
Message-ID: <72499e3b0512010400i1de76ed2la22cd745f811007f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Dec 01 13:03:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehn7b-0008VY-Tc
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 13:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVLAMA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 07:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVLAMA4
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 07:00:56 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:50267 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932178AbVLAMAz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 07:00:55 -0500
Received: by wproxy.gmail.com with SMTP id i11so330926wra
        for <git@vger.kernel.org>; Thu, 01 Dec 2005 04:00:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fQd/vour23hO3e+wZ6sGbikZVXPuMZMqB8kBSeNLBfZVWCZM4IKw8NhyA1taWQFazs1Q75oLIuj/8lZnfKcmsAmXV5G3ElIpMLKvlXUhe4NB0Zu5LZ9gccgSIHZ0U59o2ROsdLHtyVy5z0/2RxurraphghiPm04jY1dxAuU9pe8=
Received: by 10.64.196.9 with SMTP id t9mr771541qbf;
        Thu, 01 Dec 2005 04:00:54 -0800 (PST)
Received: by 10.64.203.14 with HTTP; Thu, 1 Dec 2005 04:00:54 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13051>

Hi,

There are some minor problems in git.c:

(1) potential buffer overrun.

        strncat(&git_command[len], "/git-", sizeof(git_command) - len);
        len += 5;
        strncat(&git_command[len], argv[i], sizeof(git_command) - len);

The first line will write one byte ('\0') beyond the end of
git_command, when sizeof(git_command) - len == 5.

The second line increase len by 5, without regarding how many bytes
are written in the first line.  It is possible to make len greater
than sizeof(git_command), therefore make the third argument of the
third line underflow, allowing almost any number of bytes from argv[1]
to be copied.

(2) environ

int main(int argc, char **argv, char **envp)
{
  ...
  execve(git_command, &argv[i], envp);
  ...
}

I am wondering whether the global variable "environ" could change when
you do setenv.  Would it be clear by using the "environ" as the third
argument of evecve()?

(3) printf("Failed to run command '%s': %s\n", git_command, strerror(errno));
should go to stderr?

Regards,
Robertoo
