From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] add a reflog_exists and delete_reflog abstraction
Date: Tue, 06 May 2014 17:23:10 +0200
Message-ID: <5368FE5E.7020009@alum.mit.edu>
References: <1399330677-17930-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 20:24:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiVV-0008Jm-3Z
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102AbaEFPXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 11:23:14 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61937 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755121AbaEFPXN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2014 11:23:13 -0400
X-AuditID: 12074414-f79d96d000002d2b-29-5368fe6066c9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 06.D6.11563.06EF8635; Tue,  6 May 2014 11:23:12 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97C6E.dip0.t-ipconnect.de [79.201.124.110])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s46FNAcQ031439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 6 May 2014 11:23:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399330677-17930-1-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1E34lxFs0P9N36LrSjeTxb8JNQ5M
	Hgs2lXp83iQXwBTFbZOUWFIWnJmep2+XwJ0xvf8lY8ED/ooFm1+wNTDe4uli5OSQEDCRWP1r
	HhuELSZx4d56IJuLQ0jgMqPEh0mdTBDOeSaJPZOOM4NU8QpoS/yd2M4IYrMIqEoc2zKBCcRm
	E9CVWNTTDGRzcIgKBEn8OasIUS4ocXLmExYQW0TATmL9rYVgY4QF3CS+vbnFBlIuJOAs8fIZ
	H4jJKeAi0XpfFcSUEBCX6GkMAilmFtCReNf3gBnClpfY/nYO8wRGgVlI5s9CUjYLSdkCRuZV
	jHKJOaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCHhKbKD8chJuUOMAhyMSjy8D15l
	BAuxJpYVV+YeYpTkYFIS5RX/DRTiS8pPqcxILM6ILyrNSS0+xCjBwawkwnsOJMebklhZlVqU
	D5OS5mBREuf9tljdT0ggPbEkNTs1tSC1CCYrw8GhJMG77S9Qo2BRanpqRVpmTglCmomDE2Q4
	l5RIcWpeSmpRYmlJRjwoRuOLgVEKkuIB2vsWpJ23uCAxFygK0XqKUZfjQsOKFiYhlrz8vFQp
	cd6Vf4CKBECKMkrz4FbAktErRnGgj4V594CM4gEmMrhJr4CWMAEt4TJOB1lSkoiQkmpgLE38
	MIOhrKE2zmX3T0HehN0ylj78epVbZt5I+vL9s8X6ybnzefyvcX2as8HxwSd5+7Xah/xu65zm
	faGtmP0x+qPU+eTGArMG6wP/FfRO8bXW1fg/myXEo7ZNcMeyxEUTNGoCFj+5unq3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248206>

On 05/06/2014 12:57 AM, Ronnie Sahlberg wrote:
> This is a single patch that adds two new functions to try to hide the reflog
> implementation details from the callers in checkout.c and reflog.c.
> It adds new functions to test if a reflog exists and to delete it, thus
> allowing checkout.c to perform this if-test-then-delete operation without
> having to know the internal implementation of reflogs (i.e. that they are files
> that live unde r.git/logs)
> 
> It also changes checkout.c to use ref_exists when checking for whether a ref
> exists or not instead of checking if the loose ref file exists or not.
> Using ref_exists instead both hides the reflog implementation details from
> checkout.c as well as making the code more robust against future changes.
> It currently has a hard assumption that the loose ref file must exist at this
> stage or else it would end up deleting the reflog which is true today, as far
> as I can tell, but would break if git would change such that we could have
> a branch checked out without having a loose ref file for that branch.

For single patches, people usually don't send a separate cover letter.
Any comments that you want to make that are not suitable for the commit
message can go between the "---" line and the diffstat of the patch email.

Regarding this change, I think before too long we will also need an API
to turn reflogs on for a reference.  We might want to add a flag to ref
transaction entries that cause the reflog to be created if it doesn't
already exist.  Reflogs can currently be created for a reference via the
config setting "core.logAllRefUpdates" or (for branches) by "git branch
--create-reflog" (maybe there are others).

Several tests in the test suite currently create reflog files by hand.
Thus we might also need a way to create reflogs at the command line by
the time we implement pluggable reference backends.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
