From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 20/27] update-ref --stdin: Reimplement using reference
 transactions
Date: Wed, 02 Apr 2014 07:03:34 +0200
Message-ID: <533B9A26.8050303@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-21-git-send-email-mhagger@alum.mit.edu> <xmqqppl0zvcs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:30:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeIM-0006sp-9j
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbaDBFDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 01:03:39 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49644 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755118AbaDBFDi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 01:03:38 -0400
X-AuditID: 12074411-f79ab6d000002f0e-04-533b9a29eefc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1F.F3.12046.92A9B335; Wed,  2 Apr 2014 01:03:37 -0400 (EDT)
Received: from [192.168.69.148] (p57A25BD8.dip0.t-ipconnect.de [87.162.91.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3253Ylb025720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 2 Apr 2014 01:03:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqqppl0zvcs.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqKs5yzrYoHOqqsXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4kdLD7PFx84FzA5sHjtn3WX3uPTyO5vHx2fL2T2e9e5h9Lh4Sdnj8ya5ALYo
	bpukxJKy4Mz0PH27BO6M16s2sRY081ZMX3uBrYFxM1cXIyeHhICJROfJiewQtpjEhXvr2boY
	uTiEBC4zSnzZuBjKOcckse/0e6AqDg5eAW2J6fvMQBpYBFQltu3ZzwxiswnoSizqaWYCsUUF
	giQObzjFCmLzCghKnJz5hAXEFhFQk5jYdogFZCazwGpGiaVTZrCBJIQFYiSuHNnBCLFsLaPE
	jAtXwaZyClhLHN7dxQSyWEJAXKKnMQgkzCygI/Gu7wEzhC0vsf3tHOYJjIKzkOybhaRsFpKy
	BYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfVyM0v0UlNKNzFC4kFwB+OMk3KHGAU4GJV4
	eA+ctwoWYk0sK67MPcQoycGkJMrbOdM6WIgvKT+lMiOxOCO+qDQntfgQowQHs5IIL+ckoBxv
	SmJlVWpRPkxKmoNFSZyXb4m6n5BAemJJanZqakFqEUxWhoNDSYL3IshQwaLU9NSKtMycEoQ0
	EwcnyHAuKZHi1LyU1KLE0pKMeFAMxxcDoxgkxQO09ypIO29xQWIuUBSi9RSjLseGbWsamYRY
	8vLzUqXEebtnABUJgBRllObBrYAlv1eM4kAfC/M+BhnFA0yccJNeAS1hAlrCvc4KZElJIkJK
	qoExK+n6I6m0OTOOT7+4maMnrcpm4h/5Qx6f322a/OVAyx0Pxl17Msqm3Xadp7iP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245716>

On 04/01/2014 09:46 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This change is mostly clerical: the parse_cmd_*() functions need to
>> use local variables rather than a struct ref_update to collect the
>> arguments needed for each update, and then call ref_transaction_*() to
>> queue the change rather than building up the list of changes at the
>> caller side.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
> With the implementation of ref_transaction at this point in the
> series it does not matter, but the updated code in this patch means
> that it is perfectly acceptable to do this sequence:
> 
>     ref_transaction_begin();
>     ref_transaction_update();
>     ...
>     ref_transaction_update();
>     die();
> 
> without ever calling ref_transaction_rollback() API function.
> Depending on the future backends, we may want to ensure rollback is
> called, no?  And if that is the case, we would want to prepare
> callers of the API with some at-exit facility to call rollback, no?

I assumed that rolling back a non-consummated transaction in the case of
early program death should be the responsibility of the library, not of
the caller.  If I'm correct, the caller(s) won't have to be modified
when the atexit facility is added, so I don't see a reason to add it
before it is needed by a concrete backend.

But you suggest that the caller should be involved.  Do you have an idea
for something that a caller might want to do besides roll back the
transaction?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
