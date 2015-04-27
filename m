From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Mon, 27 Apr 2015 21:40:48 +0200
Message-ID: <553E90C0.4070103@web.de>
References: <553CD3DA.9090700@web.de>	<xmqqzj5uxhls.fsf@gitster.dls.corp.google.com> <xmqqa8xtxy32.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>, kasal@ucw.cz,
	sandals@crustytoothpaste.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 21:44:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymox8-0006hj-Gy
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 21:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbbD0TlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 15:41:05 -0400
Received: from mout.web.de ([212.227.15.14]:52455 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932896AbbD0TlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 15:41:04 -0400
Received: from [192.168.209.17] ([217.211.68.12]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MddGu-1Ywmdo1aO4-00PQ5R; Mon, 27 Apr 2015 21:40:58
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqa8xtxy32.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:2o+qgQRxtNslIxFj3TQUx4hyIFiaKsrp8ibPjiGKnqhVYAPs2E+
 VtwXzMnqTWbYcw7o/T+mUVEvS9a32LzglCJhe+rKcbStrVmvK8eiEymxzaen5sU3sy8HUw/
 94l7c9vBvQb+z6svzUu9NvddxjAhBTLzKu+DTeoK++8CvzIqD5gVXLcWMU+hFnkusEWp1md
 D7kV6aEDtnSEeFQYlmCMg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267876>

On 04/27/2015 07:47 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I suspect (I haven't looked very carefully for this round yet to be
>> sure, though) that it may turn out that the commit you are proposing
>> to revert was a misguided attempt to "fix" a non issue, or to break
>> the behaviour to match a mistaken expectation.  If that is the case
>> then definitely the reversion is a good idea, and you should argue
>> along that line of justification.
>>
>> We'd just be fixing an old misguided and bad change in such a case.
> The original says this:
>
>     blame: correctly handle files regardless of autocrlf
>     
>     If a file contained CRLF line endings in a repository with
>     core.autocrlf=input, then blame always marked lines as "Not
>     Committed Yet", even if they were unmodified.  Don't attempt to
>     convert the line endings when creating the fake commit so that blame
>     works correctly regardless of the autocrlf setting.
>     
>     Reported-by: Ephrim Khong <dr.khong@gmail.com>
>     Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> But if autocrlf=input, then the end-user expectation is to keep the
> in-repository data with LF line endings.  If your tip-of-the-tree
> commit incorrectly has CRLF line endings, and if you were going to
> commit what is in the working tree on top, you would be correcting
> that mistake by turning the in-repository data into a text file with
> LF line endings, so "Not Committed Yet" _is_ the correct behaviour.
>
> So I think that the reverting that change is the right thing to do.
> It really was a change to break the behaviour to match a mistaken
> expectation, I would have to say.
Besides a better commit message (suggestions welcome),
What do you think about the following test cases for a V2 patch ?

test_expect_success 'create blamerepo' '
    test_create_repo blamerepo &&
    (
        cd blamerepo &&
        printf "testcase\r\n" >crlffile &&
        git -c core.autocrlf=false add crlffile &&
        git commit -m "add files" &&
        git -c core.autocrlf=false blame crlffile >crlfclean.txt
    )
'

test_expect_success 'blaming files with CRLF newlines in repo, core.autoclrf=input' '
    (
        cd blamerepo &&
        git -c core.autocrlf=input blame crlffile >actual &&
        grep "Not Committed Yet" actual
    )
'


test_expect_success 'blaming files with CRLF newlines core.autocrlf=true' '
    (
        cd blamerepo &&
        git -c core.autocrlf=true blame crlffile >actual &&
        test_cmp crlfclean.txt actual
    )
'

test_expect_success 'blaming files with CRLF newlines core.autocrlf=false' '
    (
        cd blamerepo &&
        git -c core.autocrlf=false blame crlffile >actual &&
        test_cmp crlfclean.txt actual
    )
'
