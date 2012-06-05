From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 5 Jun 2012 14:23:32 +0200
Message-ID: <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
References: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com>
	<7vhauqsue3.fsf@alter.siamese.dyndns.org>
	<CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com>
	<7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
	<vpqpq9ejnxs.fsf@bauges.imag.fr>
	<CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
	<20120605075614.GE25809@sigill.intra.peff.net>
	<vpq4nqqj8ss.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 14:23:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbsnT-0002zr-A6
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 14:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917Ab2FEMXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 08:23:34 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:42481 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820Ab2FEMXd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 08:23:33 -0400
Received: by ghrr11 with SMTP id r11so4200356ghr.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2/GyVxMQyREPEVWLnsBoKCIiqq0p/0UyfbwMB9DaS34=;
        b=iyecLPxgg7qgWfDDlXV+/OunfqZtzY36hs6OZTUThLV5CENFAs/2OcJaKKm4Ptwybe
         ITX1RF+SEcR49SiLasLuEvcvvwlMsaBWbn3DNMpO9YvogMX67N4/NU1IKCzJrTjFsDlg
         JczHfcA1/fQ4C+WXFIjpePw7Pn8fnVm6rdW8a5WboHROeV46yZqL6aYyo9QhA4evld20
         Ks/XBHDn1KWwIDuc74DFgJFnihmnZRdy0jlgonbhMNy2+7UXlk4LCbsbUtwMzzqyDI9z
         Ub881OZ51t8M09Dd3z6tx1jZ3jUezfiZ8EfV/Z/HBlBtzbNqbKnnOXJR7X7MoOd5Cq2B
         sSJg==
Received: by 10.236.114.161 with SMTP id c21mr11399761yhh.51.1338899012858;
 Tue, 05 Jun 2012 05:23:32 -0700 (PDT)
Received: by 10.236.175.226 with HTTP; Tue, 5 Jun 2012 05:23:32 -0700 (PDT)
In-Reply-To: <vpq4nqqj8ss.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199235>

Hi,

so I applied that patch with git apply, but here 2 out of 4 tests now
still fail.


sb@sb:~/OSS/git/t$ cat t1304-default-acl.sh
#!/bin/sh
#
# Copyright (c) 2010 Matthieu Moy
#

test_description=3D'Test repository with default ACL'

# Create the test repo with restrictive umask
# =3D> this must come before . ./test-lib.sh
umask 077

=2E ./test-lib.sh

# We need an arbitrary other user give permission to using ACLs. root
# is a good candidate: exists on all unices, and it has permission
# anyway, so we don't create a security hole running the testsuite.
test_expect_success 'checking for a working acl setup' '
       if setfacl -m u:root:rwx . &&
          getfacl . | grep user:root:rwx
       then
               test_set_prereq SETFACL
       fi
'

if test -z "$LOGNAME"
then
	LOGNAME=3D$USER
fi

check_perms_and_acl () {
	test -r "$1" &&
	getfacl "$1" > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	egrep "mask::?r--" actual > /dev/null 2>&1 &&
	grep -q "group::---" actual || false
}

dirs_to_set=3D"./ .git/ .git/objects/ .git/objects/pack/"

test_expect_success SETFACL 'Setup test repo' '
	setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx $dirs_to_set &&
	setfacl -m m:rwx               $dirs_to_set &&
	setfacl -m u:root:rwx          $dirs_to_set &&
	setfacl -m d:u:"$LOGNAME":rwx  $dirs_to_set &&
	setfacl -m d:u:root:rwx        $dirs_to_set &&

	touch file.txt &&
	git add file.txt &&
	git commit -m "init"
'

test_expect_success SETFACL 'Objects creation does not break ACLs with
restrictive umask' '
	# SHA1 for empty blob
	check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c=
5391
'

test_expect_success SETFACL 'git gc does not break ACLs with
restrictive umask' '
	git gc &&
	check_perms_and_acl .git/objects/pack/*.pack
'

test_done
sb@sb:~/OSS/git/t$ ./t1304-default-acl.sh --verbose
Initialized empty Git repository in /home/sb/OSS/git/t/trash
directory.t1304-default-acl/.git/
expecting success:
       if setfacl -m u:root:rwx . &&
          getfacl . | grep user:root:rwx
       then
               test_set_prereq SETFACL
       fi

user:root:rwx
ok 1 - checking for a working acl setup

expecting success:
	setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx $dirs_to_set &&
	setfacl -m m:rwx               $dirs_to_set &&
	setfacl -m u:root:rwx          $dirs_to_set &&
	setfacl -m d:u:"$LOGNAME":rwx  $dirs_to_set &&
	setfacl -m d:u:root:rwx        $dirs_to_set &&

	touch file.txt &&
	git add file.txt &&
	git commit -m "init"

[master (root-commit) 011f91a] init
 Author: A U Thor <author@example.com>
 0 files changed
 create mode 100644 file.txt
ok 2 - Setup test repo

expecting success:
	# SHA1 for empty blob
	check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c=
5391

not ok - 3 Objects creation does not break ACLs with restrictive umask
#=09
#		# SHA1 for empty blob
#		check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e4=
8c5391
#=09

expecting success:
	git gc &&
	check_perms_and_acl .git/objects/pack/*.pack

Counting objects: 3, done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0)
not ok - 4 git gc does not break ACLs with restrictive umask
#=09
#		git gc &&
#		check_perms_and_acl .git/objects/pack/*.pack
#=09

# failed 2 among 4 test(s)
1..4

2012/6/5 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Jeff King <peff@peff.net> writes:
>
>> Subject: t1304: improve setfacl prerequisite setup
>
>> +test_expect_success 'checking for a working acl setup' '
>> + =A0 =A0 if setfacl -m u:root:rwx . &&
>> + =A0 =A0 =A0 =A0getfacl . | grep user:root:rwx
>> + =A0 =A0 then
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_set_prereq SETFACL
>> + =A0 =A0 fi
>> +'
>
> Excellent. Thanks.
>
> Tested-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
