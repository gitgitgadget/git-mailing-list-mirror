From: Taylor Braun-Jones <taylor@braun-jones.org>
Subject: git-clone fails when current user is not in /etc/passwd
Date: Wed, 2 Dec 2015 15:10:42 -0500
Message-ID: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 21:11:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Dkq-0007Z5-Ax
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 21:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642AbbLBULw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 15:11:52 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33970 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963AbbLBULE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 15:11:04 -0500
Received: by qgeb1 with SMTP id b1so43510920qge.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 12:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=braun-jones.org; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Ge27VTQ1ezrq4s5L1/ttwwwO+jUeNQLzJVvQKch+vf4=;
        b=ObE4wFtC8O4cAtRfmImWhBnRATr1TO32yQWBX2L7v8r4L7xVmD5SxHVR9Up/vxpw9j
         JISLrwdX2J7bFJ1S3oVGGUr6TlCctqVTR6y6oYay2B3jxEsu89eGwJJO5qdDvIfHLXtB
         iLZd7UZPusGelacuHyG/aVtt9mnONwRxDXJ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Ge27VTQ1ezrq4s5L1/ttwwwO+jUeNQLzJVvQKch+vf4=;
        b=YWd5VddS2dlGcKy807KA/BCA1itgDnn6emOQcBILLHMjtS84gjerWFsJ9nXSqGcNLa
         8s7DGfbKV3Up0vOH4ienpCau43DwTKP/GidWJufm2XfnIYpFPoIoGtfBHmFIeotj97M3
         Ufn55x2Cwws641N2es1ICkM2geXq76vDV5n4CecT5GiOhdi7H2ByEHb6i+vFD/0i1Fvg
         bD9tlNZTkCaK9SMxaHu541tbG0me7oId37yfJztP+A9lr3UDb5F0VSzerPwHEiQ5Mbwi
         r2wN/Ug+qs+bJWkLy2LTmpnA9XEnDeCqL8gXAPL1R0sgEhp8D+uqSSpg0XjZnuzKIYEw
         RVfg==
X-Gm-Message-State: ALoCoQnpIC0dqXda9myjSAfdww8buA78RbAB5mYpxAnuQK/nNeWrodJJhuRKZxVrw1iA+i1MZiys
X-Received: by 10.140.94.76 with SMTP id f70mr6392016qge.3.1449087063198;
        Wed, 02 Dec 2015 12:11:03 -0800 (PST)
Received: from mail-qk0-f181.google.com (mail-qk0-f181.google.com. [209.85.220.181])
        by smtp.gmail.com with ESMTPSA id 31sm1872808qgy.13.2015.12.02.12.11.02
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 12:11:02 -0800 (PST)
Received: by qkao63 with SMTP id o63so21194054qka.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 12:11:02 -0800 (PST)
X-Received: by 10.55.215.76 with SMTP id m73mr6257219qki.16.1449087062595;
 Wed, 02 Dec 2015 12:11:02 -0800 (PST)
Received: by 10.55.128.198 with HTTP; Wed, 2 Dec 2015 12:10:42 -0800 (PST)
X-Gmail-Original-Message-ID: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281914>

My use case it running git clone inside a docker container with
`docker run --user $(id -u):$(id -g) --volume /foo:/foo ...`. I want
all /foo/* file creation/access from inside the Docker container to be
done as the current uid/gid of the host system.

Steps to reproduce:

mkdir /tmp/docker-git
cat > /tmp/docker-git/Dockerfile <<EOF
FROM ubuntu
RUN apt-get update && apt-get install -y git-core
EOF
docker build -t git /tmp/docker-git/
docker run --user $(id -u):$(id -g) git git clone
https://github.com/git/git.git /tmp/git
# fatal: unable to look up current user in the passwd file: no such user
echo $? # 128

My current workaround is:

cat >> /tmp/docker-git/Dockerfile <<EOF
RUN git config --system user.name Docker && git config --system
user.email docker@localhost
EOF

But I don't see why this should be necessary just to clone a repo. I
run complex build jobs inside a docker container using this approach
and git-clone is the first command to fail due to the lack of a passwd
file entry for the current user. Some complain to stderr, but still
succeed.

Regards,
Taylor
