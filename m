From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv3 00/13] the refs-transactions-reflog series
Date: Thu, 04 Dec 2014 18:10:15 +0100
Message-ID: <54809577.4080302@alum.mit.edu>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>, ronniesahlberg@gmail.com,
	jrnieder@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 18:10:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwZv7-0002K6-J1
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 18:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbaLDRKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 12:10:21 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54422 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751407AbaLDRKU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 12:10:20 -0500
X-AuditID: 1207440c-f79376d00000680a-08-54809579dae6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 93.9C.26634.97590845; Thu,  4 Dec 2014 12:10:17 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4HAFKE009648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 12:10:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqFs5tSHEYOkyFYuuK91MFg29V5gt
	3t5cwmjR2/eJ1WLz5nYWB1aPnbPusnss2FTqcfGSssfnTXIBLFHcNkmJJWXBmel5+nYJ3BkH
	f4kV3OeumHUtsIHxBmcXIyeHhICJxPb9U9ghbDGJC/fWs3UxcnEICVxmlJh1fCEjhHOWSaLv
	8HJGkCpeAW2J7inXWLoYOThYBFQlDt7iBQmzCehKLOppZgKxRQWCJE7uuc4OUS4ocXLmE7By
	EYECiYs/OUBMZgFxif5/YFFhAQeJjlP8IKaQgJPExm3aICangLPEvVZ7kBHMAnoSO67/YoWw
	5SWat85mnsAoMAvJ9FlIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQLzezRC81
	pXQTIySQeXYwflsnc4hRgINRiYe3YHd9iBBrYllxZe4hRkkOJiVR3gNNDSFCfEn5KZUZicUZ
	8UWlOanFhxglOJiVRHi1fIFyvCmJlVWpRfkwKWkOFiVxXtUl6n5CAumJJanZqakFqUUwWRkO
	DiUJXuEpQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoNiMLwZGJ0iKB2jvApB2
	3uKCxFygKETrKUZFKXFeeZCEAEgiozQPbiwsPb1iFAf6Upg3D6SKB5ja4LpfAQ1mAhp8tqEW
	ZHBJIkJKqoGx5iRLoeTkb97L2Yz2qD0+wCXd83rGs/W78ku+MP/bLro8c67y/ocv9wnH+hnv
	c3hQbzPly8abDRPWqfPo+593tb7kEpD7wJ/5V+PpANe/xw5+Sgq7vG9FzoYT/wVn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260767>

On 12/04/2014 09:29 AM, Stefan Beller wrote:
> This is the whole refs-transactions-reflog series[1],
> which was in discussion for a bit already. It applies to origin/master.

I am still unhappy with the approach of this series, for the reasons
that I explained earlier [1]. In short, I think that the abstraction
level is wrong. In my opinion, consumers of the refs API should barely
even have to *know* about reflogs, let alone implement reflog expiration
themselves.

Of course, reflog expiration *should* be done atomically. But that is
the business of the refs module; callers shouldn't have to do all the
complicated work of building the transaction themselves.

I spent the day working on an alternate proposal, to convert
expire_reflogs() to take callback functions that decide *what* to
expire, but which itself does the work of acquiring locks, iterating
through the reflog entries, rewriting the file, and overwriting the old
file with the new one. The goal is to move this function into refs.c and
make builtin/reflog.c much simpler--it will only have to implement the
callbacks that determine the expiration policy.

I'm almost done with the series but won't be able to finish it until
tomorrow. For those who are impatient, here is my work in progress [2].

Michael

[1]
http://thread.gmane.org/gmane.comp.version-control.git/259712/focus=259770
[2] https://github.com/mhagger/git, branch "reflog-expire-api".

-- 
Michael Haggerty
mhagger@alum.mit.edu
