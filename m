From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Tue, 28 Apr 2015 09:40:09 +0200
Message-ID: <553F3959.1060202@web.de>
References: <553CD3DA.9090700@web.de>	<xmqqzj5uxhls.fsf@gitster.dls.corp.google.com>	<xmqqa8xtxy32.fsf@gitster.dls.corp.google.com>	<553E90C0.4070103@web.de> <xmqqbni8vhiz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>, kasal@ucw.cz,
	sandals@crustytoothpaste.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 09:41:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn09P-0002hJ-1m
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 09:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbbD1Hle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2015 03:41:34 -0400
Received: from mout.web.de ([212.227.17.11]:54883 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbbD1Hlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 03:41:32 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LrarZ-1ZRadu1oHF-013Qaw; Tue, 28 Apr 2015 09:41:19
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqbni8vhiz.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:WCeMxkEvw0XIJipAdlVBViZFxShaLvciVg+pMR0xuG2jhjmv+3A
 nuOTWbxFwEfzjkqC7nkXo8cT6VcZSXbfllnwYcKOC8pe0IE8srurruiCDg10LQ6lZRqkIp/
 HuPMLv+coSP6ji6+vPrIgTzkYES9fCxU+QP1J50dvSXd9SnkqqLmE55ULAua2nHrDRSryoX
 ZwiLuG6EOMzeLQWMhcBQw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267912>



On 28/04/15 09:28, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen<tboegi@web.de>  writes:
>
>> What do you think about the following test cases for a V2 patch ?
>>
>> test_expect_success 'create blamerepo' '
>>      test_create_repo blamerepo &&
>>      (
>>          cd blamerepo &&
>>          printf "testcase\r\n" >crlffile &&
>>          git -c core.autocrlf=3Dfalse add crlffile &&
>>          git commit -m "add files" &&
>>          git -c core.autocrlf=3Dfalse blame crlffile >crlfclean.txt
>>      )
>> '
>>
>> test_expect_success 'blaming files with CRLF newlines in repo, core.=
autoclrf=3Dinput' '
>>      (
>>          cd blamerepo &&
>>          git -c core.autocrlf=3Dinput blame crlffile >actual &&
>>          grep "Not Committed Yet" actual
> Are you interested in seeing just some of the lines to show up as
> "Not commited yet", or all of them?  I think it would be the latter,
> so perhaps
>
>      ! grep -v "Not Committed Yet" actual
>
> or something?
>
>>      )
>> '
>>
>>
> Two blank lines only here?
>
>> test_expect_success 'blaming files with CRLF newlines core.autocrlf=3D=
true' '
>>      (
>>          cd blamerepo &&
>>          git -c core.autocrlf=3Dtrue blame crlffile >actual &&
>>          test_cmp crlfclean.txt actual
>>      )
>> '
> OK
Interestingly this test doesn't pass on one of my systems,
after having stripped t8003 to contain to only have the corner cases.
When core.autocrlf is true, the converting should be suppressed:
  convert.c/has_cr_in_index() should return 1, but doesn't.

  data =3D read_blob_data_from_cache(path, &sz);
and data is NULL.

Some more digging has to be done here.

On the other hand we want to test blame on a file with LF in the
repo and CRLF in the workspace as well.

So all in all I need to send a V2.





>
>> test_expect_success 'blaming files with CRLF newlines core.autocrlf=3D=
false' '
>>      (
>>          cd blamerepo &&
>>          git -c core.autocrlf=3Dfalse blame crlffile >actual &&
>>          test_cmp crlfclean.txt actual
>>      )
>> '
> Hmm, how's this blame invocation any different from the one done in
> the set-up step at the very beginning?  In other words, I am not sure
> what kind of breakage could cause this step to fail.
>
> I see there is no "git blame HEAD crlffile" that bypasses the fake
> latest commit altogether.  Wouldn't that be the most appropriate
> thing to compare against (i.e. how to create crlfclean.txt in the
> set-up step)?
>
Jepp,

There is room for improvements.
