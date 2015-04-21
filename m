From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [BUG] Git does not convert CRLF=>LF on files with \r not before
 \n
Date: Tue, 21 Apr 2015 21:28:11 +0200
Message-ID: <5536A4CB.9050000@web.de>
References: <CAFFOgCUTxnbL7vJpf1Hw39CJL_p2raDZ2a3DehhYhdbkVyi2fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexandre Garnier <zigarn@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 21:28:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkdqJ-0003O2-RH
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 21:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbbDUT2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 15:28:17 -0400
Received: from mout.web.de ([212.227.17.11]:59508 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756000AbbDUT2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 15:28:16 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Maaur-1Z4nFl0FGj-00K5K4; Tue, 21 Apr 2015 21:28:12
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAFFOgCUTxnbL7vJpf1Hw39CJL_p2raDZ2a3DehhYhdbkVyi2fw@mail.gmail.com>
X-Provags-ID: V03:K0:VihWmWCkPMSGALT2O5XdBFRokrgC//Fbv8KKslYUyDN6qIyqi/T
 mlLUHHSzdUP9N9gUVSmjvu3OgwzwTS6GWusBSLbu18j0oVxXWILFP9HWIUzNjvcKIxFEXAr
 yOHjJ+WWEHVR+ovcOLR7ZOxKCGkGEEId5EEf0UkgXYigbS5l8r3/hYOhuvc00yRZK+mnfxE
 GHtncQ6IxqoVScuQdUfvw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267549>

On 2015-04-21 15.51, Alexandre Garnier wrote:
> Here is a test:
> 
> git init -q crlf-test
> cd crlf-test
> echo '*       text=auto' > .gitattributes
> git add .gitattributes
> git commit -q -m "Normalize EOL"
> echo -ne 'some content\r\nother \rcontent with CR\r\ncontent\r\nagain
> content with\r\r\n' > inline-cr.txt
> echo "Working directory content:"
> cat -A inline-cr.txt
> echo
> git add inline-cr.txt
> echo "Indexed content:"
> git show :inline-cr.txt | cat -A
> 
> Result
> ------
> File content:
> some content^M$
> other ^Mcontent with CR^M$
> content^M$
> again content with^M^M$
> 
> Indexed content:
> some content^M$
> other ^Mcontent with CR^M$
> content^M$
> again content with^M^M$
> 
> Expected result
> ---------------
> File content:
> some content^M$
> other ^Mcontent with CR^M$
> content^M$
> again content with^M^M$
> 
> Indexed content:
> some content$
> other ^Mcontent with CR$
> content$
> again content with^M$
> # or even 'again content with$' for this last line
> 
> If you remove the \r that are not at the end of the lines, EOL are
> converted as expected:
> File content:
> some content^M$
> other content with CR^M$
> content^M$
> again content with^M$
> 
> Indexed content:
> some content$
> other content with CR$
> content$
> again content with$
> 

First of all, thanks for the info.

The current implementation of Git does an auto-detection
if a file is text or binary.

For a file which is "suspected to be text", it is expected to have either LF or CRLF as
line endings, but a "bare CR" make Git wonder:
Should this still be treated as a text file ?
If yes, should the CR be kept as is, or should it be converted into LF (or CRLF) ?

The current implementation may simply be explained by the fact that nobody has so far asked 
to treat this file as "text", so the implementation assumes it to be binary.

(Which makes the code a little bit easier, at the time it was written)

So the status of today is that you can force Git to let the CR as is,
when you specify that the file is "text".

Is there a real life problem behind it ?
And what should happen to the CRs ?
