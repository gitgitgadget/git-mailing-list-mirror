From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: git clone silently aborts if stdout gets a broken pipe
Date: Wed, 18 Sep 2013 18:52:13 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC798CD91DB0B@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A612847CFE53224C91B23E3A5B48BAC798CD91DB0Bxmail3seaxisc_"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 18 18:58:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VML56-0002B7-6j
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 18:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab3IRQ6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 12:58:14 -0400
Received: from anubis.se.axis.com ([195.60.68.12]:46953 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab3IRQ6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 12:58:12 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Sep 2013 12:58:12 EDT
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 84FB519E0F
	for <git@vger.kernel.org>; Wed, 18 Sep 2013 18:52:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GGN43BTUhDeY for <git@vger.kernel.org>;
	Wed, 18 Sep 2013 18:52:13 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id BE75B19E09
	for <git@vger.kernel.org>; Wed, 18 Sep 2013 18:52:13 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id A81618DA
	for <git@vger.kernel.org>; Wed, 18 Sep 2013 18:52:13 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 9D092789
	for <git@vger.kernel.org>; Wed, 18 Sep 2013 18:52:13 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by seth.se.axis.com (Postfix) with ESMTP id 9B52A3E06F
	for <git@vger.kernel.org>; Wed, 18 Sep 2013 18:52:13 +0200 (CEST)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Wed, 18 Sep 2013 18:52:13 +0200
Thread-Topic: git clone silently aborts if stdout gets a broken pipe 
Thread-Index: Ac60j12YFc43TbFEQA2ZRzFumfedkA==
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234973>

--_002_A612847CFE53224C91B23E3A5B48BAC798CD91DB0Bxmail3seaxisc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

One of our Perl scripts that does a git clone suddenly=20
started to fail when I upgraded to git 1.8.4 from 1.8.3.1.

The failing Perl code used a construct like this:

	Git::command_oneline('clone', $url, $path);

There is no error raised, but the directory specified by=20
$path is not created. If I look at the process using strace=20
I can see the clone taking place, but then it seems to get=20
a broken pipe since the code above only cares about the=20
first line from stdout (and with the addition of "Checking=20
connectivity..." git clone now outputs two lines to stdout).

If I change the code to:

	my @foo =3D Git::command('clone', $url, $path);

it works as expected.

I have attached a simple Perl script that shows the problem.
Run it as "clone_test.pl <git url>". With git 1.8.4 it will=20
fail for the first two test cases, whereas with older git=20
versions it succeeds for all four test cases.

I hope this is enough information for someone to look into=20
this regression.

Best regards,
//Peter


--_002_A612847CFE53224C91B23E3A5B48BAC798CD91DB0Bxmail3seaxisc_
Content-Type: application/octet-stream; name="clone_test.pl"
Content-Description: clone_test.pl
Content-Disposition: attachment; filename="clone_test.pl"; size=796;
	creation-date="Wed, 18 Sep 2013 18:25:55 GMT";
	modification-date="Wed, 18 Sep 2013 18:00:03 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL3BlcmwKCnVzZSBHaXQ7CgpteSAkdXJsID0gJEFSR1ZbMF0gfHwgZGllKCJZb3UgbmVl
ZCB0byBzcGVjaWZ5IGEgR2l0IFVSTCFcbiIpOwpteSAkcGF0aCA9ICdjbG9uZV90ZXN0JzsKCnN5
c3RlbSgicm0gLXJmICR7cGF0aH0xIik7CkdpdDo6Y29tbWFuZF9vbmVsaW5lKCdjbG9uZScsICIk
dXJsIiwgIiR7cGF0aH0xIik7Cndhcm4oIkZhaWxlZCB0byBjbG9uZSB0byAke3BhdGh9MSFcbiIp
IHVubGVzcyAoLWQgIiR7cGF0aH0xIik7CgpzeXN0ZW0oInJtIC1yZiAke3BhdGh9MiIpOwpteSAk
Zm9vID0gR2l0Ojpjb21tYW5kX29uZWxpbmUoJ2Nsb25lJywgJHVybCwgIiR7cGF0aH0yIik7Cndh
cm4oIkZhaWxlZCB0byBjbG9uZSB0byAke3BhdGh9MiFcbiIpIHVubGVzcyAoLWQgIiR7cGF0aH0y
Iik7CgpzeXN0ZW0oInJtIC1yZiAke3BhdGh9MyIpOwpteSAkZm9vID0gR2l0Ojpjb21tYW5kKCdj
bG9uZScsICR1cmwsICIke3BhdGh9MyIpOwp3YXJuKCJGYWlsZWQgdG8gY2xvbmUgdG8gJHtwYXRo
fTMhXG4iKSB1bmxlc3MgKC1kICIke3BhdGh9MyIpOwoKc3lzdGVtKCJybSAtcmYgJHtwYXRofTQi
KTsKbXkgQGZvbyA9IEdpdDo6Y29tbWFuZCgnY2xvbmUnLCAkdXJsLCAiJHtwYXRofTQiKTsKd2Fy
bigiRmFpbGVkIHRvIGNsb25lIHRvICR7cGF0aH00IVxuIikgdW5sZXNzICgtZCAiJHtwYXRofTQi
KTsKCnN5c3RlbSgicm0gLXJmICR7cGF0aH0xIik7CnN5c3RlbSgicm0gLXJmICR7cGF0aH0yIik7
CnN5c3RlbSgicm0gLXJmICR7cGF0aH0zIik7CnN5c3RlbSgicm0gLXJmICR7cGF0aH00Iik7Cg==

--_002_A612847CFE53224C91B23E3A5B48BAC798CD91DB0Bxmail3seaxisc_--
