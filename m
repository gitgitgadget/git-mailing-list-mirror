From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: git smudge filter fails
Date: Wed, 9 Mar 2016 13:29:31 -0500
Message-ID: <CAH8BJxHwxp2BtzGBqi6J24Kh0TTGEdCx=-Scu+bx5N-ZVpBZNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 09 19:29:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adira-0001vT-B4
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933657AbcCIS3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:29:34 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35941 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933607AbcCIS3d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:29:33 -0500
Received: by mail-wm0-f45.google.com with SMTP id n186so191999717wmn.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=xEt0UIC4/vWB6HTgfB9pNohrmDpyPWw++TyNYpu3iL8=;
        b=D/pvG8l+0Z26ST2WfzsUoZxE8Y2ra3A40A31ngs2X40uiBUgj+Voqzqhc2cL/O8mNa
         QEWfALmSZ8oecCwBN7z9IzA/URixC+j8w3wL/KFaP12f8J8fLFPG8f3dcUNbQ1mCDZnP
         zOzQXCTH1lbEvs7kBAT53gWdC89gB5XXt7Nu5HXfQSaX2naZajFqtRG3rG+8KfiEFS65
         RbT8Yo9lCQN+D7wjedd0VqjEEsjEk7k/UhFhR74piaI7n6FpCIxC5XUTM+5V5VPWWhUw
         ItQnyCOmPUKNi5fy5853ivPevznzK1ZQhZrQaAT8wMZklCwQGASnTALqpConeImLjvNe
         2xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xEt0UIC4/vWB6HTgfB9pNohrmDpyPWw++TyNYpu3iL8=;
        b=Qozl+3vGY3GMWj+UrWzZyNAJlbDsqQbnUKV+hh/wrm1bC4NYr+x4+8AKYHR8cuWWzn
         HGbtwHRHDCeVb5YjYQX4WxdhojSopZdS4V+17AF0vl5LOD5X+ICpkCF5vdEVHjwXdKY6
         oWxLLBYUhJ05RJvXL2pp6caUwyf5AbmyjIwHcd3dSm0QRJLhkvPr2mQC8Z44xi9Lt1Sp
         uFsf/XMDNMCdklPpH//cz9a5V4wsQxYnXO0osX+w2sgoNWszXhEbtsCei9X93bpLA4io
         WCeuC5ohkrnm0OAP5hATYa15u5kM19Wywo4ck4slUDo9wnmdZ9/EyJCs1ZvSwvrGTrti
         QHOw==
X-Gm-Message-State: AD7BkJJPgIczvwycwsvqsoSwJJUDHJdWlcdfvGD4dUd18qQtVLCBMn1eMWNJJYQSFrXHm8dhzsRKPyKobY7ZUw==
X-Received: by 10.28.126.8 with SMTP id z8mr539441wmc.77.1457548171945; Wed,
 09 Mar 2016 10:29:31 -0800 (PST)
Received: by 10.194.63.82 with HTTP; Wed, 9 Mar 2016 10:29:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288547>

A git smudge filter, at least one that relies on the results from 'git
log' does not seem to work
on file A when doing a 'git update' from a revision where file A
doesn't exist to a revision where
it does exist.

Below is a simple recipe to reproduce.

This appears to me to be a bug. If not, why is it expected and is
there anything I can do to
work around this behaviour?

Steve

mkdir git_test
cd git_test/
git init .
touch bar.c
git add .
git commit -am "Initial commit. foo.c not here yet."
git tag no_foo

touch foo.c
git add .
git commit -am "Add foo, no content"
echo 'Date is $Date$' >> foo.c
git commit -am "Add date to foo.c"
echo 'foo.c filter=dater' > .git/info/attributes
git config --local filter.dater.smudge 'myDate=`git log
--pretty=format:"%cd" --date=iso -1 -- %f`; sed -e
"s/\(\\$\)Date[^\\$]*\\$/\1Date: $myDate \\$/g"'
git config --local filter.dater.clean 'sed -e
"s/\(\\$\)Date[^\\$]*\\$/\1Date\\$/g"'
rm -f foo.c
git checkout -- foo.c
cat foo.c
# observe keyword expansion

git checkout no_foo
git checkout master
cat foo.c
#observe keyword expansion lost
