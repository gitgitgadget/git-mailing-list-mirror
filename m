From: Jan-Philip Gehrcke <jgehrcke@googlemail.com>
Subject: Should the --encoding argument to log/show commands make any guarantees
 about their output?
Date: Mon, 15 Jun 2015 10:50:26 +0200
Message-ID: <557E91D2.3000908@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 10:50:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Q6J-0004lD-DX
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 10:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbbFOIuf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2015 04:50:35 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36332 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052AbbFOIud (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 04:50:33 -0400
Received: by lbbqq2 with SMTP id qq2so48992697lbb.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 01:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=E02fBHUdCtaIQDKqTkW+iGB5d8w6M64rsjZrm31zqIo=;
        b=qIOumFW0DwQt7Vje5mL3MHYlZbanVVbzjufKLbc+BZwW9C/mAXlP7+SqPwyo3h1MCB
         5A4vmJkozn51ah+Y89zpC6OARtT322y+p1HE00c8kRp2vYJrA0Sxy7ykBFODXzylQ2il
         WgoxF9U1naYfm82sBh7pF5ZDIDmH6UwJDj9EtXFUF6mINwV6/wtQhWDTrDBUciPIKLjI
         rOcZzF9kqm40l83RZBM/JRn45ed4xgjjFkaNRQSGCS9UGFFL4nRD6qf01P6S33WfHosr
         EeBKU9dsEXuYxUh+oMWNuUBfAgbDOVJ0O954e+0/BJGGZmvEdDMCmKhW/RmU5MqCBkVO
         9h2w==
X-Received: by 10.152.116.49 with SMTP id jt17mr12815577lab.82.1434358232113;
        Mon, 15 Jun 2015 01:50:32 -0700 (PDT)
Received: from [192.168.178.11] (ip92342367.dynamic.kabel-deutschland.de. [146.52.35.103])
        by mx.google.com with ESMTPSA id f2sm2567370lah.39.2015.06.15.01.50.29
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2015 01:50:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271663>

Hello,

I was surprised to see that the output of

     git log --encoding=3Dutf-8 "--format=3Dformat:%b"

can contain byte sequences that are invalid in UTF-8. Note: I am using=20
git 2.1.4 and the %b format specifier represents the commit message bod=
y.

I have seen this with the Linux git repository and the following test:

     git log --encoding=3Dutf-8 "--format=3Dformat:%b" | python2 -c \
         'import sys; [l.decode("utf-8") for l in sys.stdin]'

Soon enough errors like this appears:

     'utf8' codec can't decode byte 0xf6 in position 19

The help message to the --encoding argument reads:

> The commit objects record the encoding used for the log message in
> their encoding header; this option can be used to tell the command to
> re-code the commit log message in the encoding preferred by the user

I realize that this message does not give any guarantee about the outpu=
t=20
of the command, in the sense that --encoding=3Dutf-8 produces valid UTF=
-8=20
data in all cases.

However, I wonder what --encoding precisely does and if it has the=20
behavior most users would expect.

Let me describe what I think it currently does:

The program attempts to re-code a log message, so it follows the chain

	raw input -> unicode -> raw output

=46or the first step, knowledge about the input encoding is required. T=
his=20
is retrieved from the encoding header of the commit object if present o=
r=20
(from the docs) "lack of this header implies that the commit log messag=
e=20
is encoded in UTF-8." If this step fails (if the entry contains a byte=20
sequence that is invalid in the specified/assumed input codec), the=20
procedure is aborted and the data is dumped as is (obviously without=20
applying the requested output encoding).

Is that correct?

 From my point of view the most natural abstraction of a log *message*=20
is *text*, not bytes. The same is true for author names. If I want to=20
build a tool chain on top of log/show, this usually means that I want t=
o=20
work with text information. Hence, I want to retrieve text (a sequence=20
of code points) from git show/log. Text must be transported in encoded=20
form, sure, but it must not contain byte sequences that are invalid in=20
this codec. Because otherwise it's just not text anymore.

Hence, from my point of view, the rational that git show/log should be=20
able to output *text* information means that they should not emit byte=20
sequences that are invalid in the codec specified via the --encoding=20
argument. In the current situation, the work of dealing with invalid=20
byte sequences is just outsourced to software further below in the tool=
=20
chain (at some point a replacement character =EF=BF=BD should be displa=
yed to=20
the user instead of the invalid raw bytes).

I am not entirely sure where this discussion should lead to. However, I=
=20
think that if the behavior of the software will not be changed, then th=
e=20
documentation for the --encoding option should be more precise and=20
clarify what actually happens behind the scenes. What do you think?


Cheers,


Jan-Philip Gehrcke
