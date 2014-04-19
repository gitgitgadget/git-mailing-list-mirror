From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 11/11] walker.c: use ref transaction for ref updates
Date: Sat, 19 Apr 2014 21:48:42 +0200
Message-ID: <5352D31A.6000107@alum.mit.edu>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com> <1397763987-4453-12-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:48:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbbFq-0005JC-2c
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbaDSTsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:48:46 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52422 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191AbaDSTso (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 15:48:44 -0400
X-AuditID: 1207440d-f79d86d0000043db-16-5352d31c0e12
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.02.17371.C13D2535; Sat, 19 Apr 2014 15:48:44 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2858.dip0.t-ipconnect.de [93.219.40.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3JJmg2N020398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 19 Apr 2014 15:48:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397763987-4453-12-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA02STUwTQRiGnd22bKHbDEuxYyEQmijR0voTUQ6AHjhwUiw3LzDQpdvYLs1u
	y08jsagnQKweJFQTgfgXDZSARM4kJoBUCVUSDQFJNMSmRSNiYhRwx8rP7Z3vfb55M/N9DM3d
	VJsYl+jjJRG7zZp0FZdWUWDNjdmrjz0c15Z0vO2kSjZDl89SlX0j/sq1kbwq6mJGaR32NVW7
	nOLR8toM4fmPdco7zLS8CiVUQbCs6QBaBsGTKL4eBSm9H80uRpR6OsPBGEAvE5P/D68plFy7
	849ioQV9eZykiFbBg2ghNqgmWgOtaKDrmlJnmGxoR3+iBSk8E031flIRbYDlKPKhnyY6C1ai
	zbloGtEcDKCxhTUNadXCCpToMRCJoBF1tdsJQcMitNr9kU7pfPQieY8OARjeExDeg4X3YH2A
	fgrysNvvsXqwyy3z9Va5HosiL1lP2Dwun413+EdA6kPZcbA1lDsBIAPMOna46kI1p8ZNcqtn
	AhxgKHM2uxGxV3P6ukZHq4BloUbyu3l5AiCGNhvYyLTisQ7cGuClxm0rh1GZjeyhB4XnOOjE
	Pv4Sz3t5advNZRgzYmvnlMZMiXfyLQ0ut2/XphgtuTzdZJB50cFL2O8TashIa2RlpsTSKbnN
	pJ2VvdijVFOt08DKzAafXKc4ldgo8iYjayEQJJDgF3citvcoDozKi7PYMkLplC3buSmuhFBK
	yMZMFQnx4V3LFAQdTq3UAPpvNyTjY6f1K28GbrTNh+cH1TPx1eacUsuSO+ZRRaKdY4vvbD/p
	LUtJoH2ld/RrQl8c2ErrnBUK73+rzf6+PDq0aTuVj4fYnuBUxZz06Dxua87vfX9F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246539>

On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
> Switch to using ref transactions in walker_fetch(). As part of the refactoring
> to use ref transactions we also fix a potential memory leak where in the
> original code if write_ref_sha1() would fail we would end up returning from
> the function without free()ing the msg string.

I don't have time to review this last patch this evening, but one thing
struck me.  It seems like the old code went to extra effort to lock all
the write_ref references early in the function, whereas your modified
version doesn't lock them until later.  Have you verified that you are
not opening a possible race condition?  If so, your commit message
should justify that it isn't a problem.  In other words, what does the
code do between the old time of locking and the new time of locking and
why doesn't it care whether the references are locked?

Aside from my other comments, patches 01-10 in the series looked fine.
Thanks!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
