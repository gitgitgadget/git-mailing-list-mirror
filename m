From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include log_config module in apache.conf
Date: Wed, 11 Mar 2009 13:13:38 -0700
Message-ID: <7vhc1z4y31.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903102320170.19665@iabervon.org>
 <alpine.DEB.1.00.0903111240150.10279@pacific.mpi-cbg.de>
 <7vab7r6g59.fsf@gitster.siamese.dyndns.org>
 <E7E9DDFD-F8F6-4B39-A3E3-48CC1C8F5BBC@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 21:20:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhUpf-0000UU-1x
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 21:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbZCKUNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 16:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbZCKUNr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 16:13:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbZCKUNq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 16:13:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E7EE539F;
	Wed, 11 Mar 2009 16:13:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9B595539C; Wed,
 11 Mar 2009 16:13:39 -0400 (EDT)
In-Reply-To: <E7E9DDFD-F8F6-4B39-A3E3-48CC1C8F5BBC@silverinsanity.com> (Brian
 Gernhardt's message of "Wed, 11 Mar 2009 15:33:27 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1F34C93A-0E79-11DE-A00A-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112973>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On Mar 11, 2009, at 2:58 PM, Junio C Hamano wrote:
>
>> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
>> index a0d4077..f460e40 100644
>> --- a/t/lib-httpd/apache.conf
>> +++ b/t/lib-httpd/apache.conf
>> @@ -4,7 +4,9 @@ DocumentRoot www
>> LogFormat "%h %l %u %t \"%r\" %>s %b" common
>> CustomLog access.log common
>> ErrorLog error.log
>> -LoadModule log_config_module modules/mod_log_config.so
>> +<IfModule !mod_log_config.c>
>> +	LoadModule log_config_module modules/mod_log_config.so
>> +</IfModule>
>>
>> <IfDefine Darwin>
>> 	LoadModule log_config_module modules/mod_log_config.so
>
> Isn't this last line redundant now?

<IfDefine Darwin>
	LoadModule log_config_module modules/mod_log_config.so
	LockFile accept.lock
	PidFile httpd.pid
</IfDefine>

I think we can lose the first among these three lines safely, but I wonder 
if we can get rid of the Darwin specific part altogether.

-- >8 --
Subject: http tests: Darwin is not that special

We have PidFile definition in the file already, and we have added
necessary LoadModule for log_config_module recently.

This patch will end up giving LockFile to everybody not just limited to
Darwin, but why not?

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-httpd/apache.conf |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index f460e40..6533c2d 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -1,5 +1,6 @@
 ServerName dummy
+LockFile accept.lock
 PidFile httpd.pid
 DocumentRoot www
 LogFormat "%h %l %u %t \"%r\" %>s %b" common
 CustomLog access.log common
@@ -8,12 +9,6 @@ ErrorLog error.log
 	LoadModule log_config_module modules/mod_log_config.so
 </IfModule>
 
-<IfDefine Darwin>
-	LoadModule log_config_module modules/mod_log_config.so
-	LockFile accept.lock
-	PidFile httpd.pid
-</IfDefine>
-
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
 
