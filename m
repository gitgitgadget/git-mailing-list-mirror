From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Fri, 06 Mar 2015 06:59:09 +0100
Message-ID: <54F9422D.2020800@web.de>
References: <54F88684.3020905@alum.mit.edu> <xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 06 06:59:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTlIL-0007fN-N6
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 06:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbbCFF73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 00:59:29 -0500
Received: from mout.web.de ([212.227.17.12]:60246 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755750AbbCFF72 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 00:59:28 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LilJB-1XtLCz0zZV-00cywf; Fri, 06 Mar 2015 06:59:24
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:7qxpxltVg5qFhxa/Mcl9EgBtjr5+Ni1B8BIyjQRSt3Df4YoVvX8
 XcBcc9C2Qs3jZe/QL6PQC2mMHkP7S7TGfA3CN/4jCKzJDCNAeh35p5hNn7liPKD1pJG4w9b
 zxUsMp/byM1y1a1k+ho1vOG4OXiNqpFnqPeag7J3iVxjr6W92hf5+dTDxqsAcOf6po83Wg5
 PbokserVhSzzqdAsDgGkQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264891>

On 03/05/2015 11:08 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> I would expect that the following .gitattributes file
>>
>>      *       eol=crlf
>>      *.png   -text
>>
>> would leave EOL translation turned off for PNG files. In other words, I
>> would expect that explicitly setting "-text" would take precedence over
>> the fact that setting "eol" implies that a file should be considered to
>> be "text".
>>
>> I would even more strongly expect
>>
>>      *       eol=crlf
>>      *.png   binary
>>
>> to turn off EOL translation for PNG files.
>>
>> But in fact, in both of the above cases, EOL translation is turned *on*
>> for PNG files.
>>
>> I propose that "-text" should override any setting for "eol" (which
>> would of course fix both problems, since "binary" is equivalent to
>> "-diff -merge -text"). What do people think?
> Hmm, is there really something that needs a new proposal and
> opinions?
>
> The way I read the flow in convert.c is:
>
>      convert_to_git() uses input_crlf_action() to figure out what
>      crlf_to_git() conversion is necessary.
>
>      input_crlf_action() looks at text_attr and says CRLF_BINARY when
>      it is CRLF_BINARY without looking at eol_attr at all.
>
>      text_attr above is ca.crlf_action in convert_to_git().
>
>      The whole ca.* comes from convert_attrs() inspecting attributes
>      on the incoming path.
>
>      convert_attrs() inspects "eol" and "text" attributes, among
>      others, and sets crlf_action by calling git_path_check_crlf().
>
>      git_path_check_crlf() looks at the 'text' attribute; if it is
>      set to false, it returns CRLF_BINARY.
>
>      crlf_to_git() when given crlf_action==CRLF_BINARY is a no-op.
>
> So, with the above attributes where anything is eol=crlf by default
> and in addition *.png is binary (which contains -text), we shouldn't
> get any crlf munging.  Am I reading/following the code incorrectly?
>
> Puzzled....
> --

I need to admit that I can't reproduce it here,
the following should trigger it, but all test cases pass


diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh

index 452320d..22f031d 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -37,7 +37,8 @@ create_gitattributes () {
                 echo "*.txt text" >.gitattributes
                 ;;
                 -text)
-               echo "*.txt -text" >.gitattributes
+               echo "* eol=crlf" >.gitattributes
+               echo "*.txt -text" >>.gitattributes
                 ;;
                 crlf)
                 echo "*.txt eol=crlf" >.gitattributes
