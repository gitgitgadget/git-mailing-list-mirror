From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 05/18] fsck: Allow demoting errors to warnings via
 receive.fsck.warn =?UTF-8?Q?=3D=20=3Ckey=3E?=
Date: Wed, 21 Jan 2015 19:01:47 +0100
Organization: gmx
Message-ID: <07b285ef702031fdebcf9def59528b9c@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
 <3fd56573b263f2a4551c9a363d1a44728573a1c6.1421682369.git.johannes.schindelin@gmx.de>
 <xmqqlhkwy0my.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 19:02:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDzbM-0005Ku-5Q
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 19:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbbAUSB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 13:01:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:57924 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbbAUSBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 13:01:55 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MCcOw-1Y4bwk2EGQ-009SE5; Wed, 21 Jan 2015 19:01:48
 +0100
In-Reply-To: <xmqqlhkwy0my.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:IwjGCoi0ndjtiPFh0mIYHY3E6Q0QzVSiMrXVyu6as70amLFE7yx
 vJFt3HEKJjMfS0Dzf8VBeCkOJ1oRyggKT0iYHVkx7JT8UJnfjLqwNi0Zfd6b8uwAAuOdnuA
 3VDl6ydVCsFSu0Ki3wjVkOSOC7YrNHOWRfhH/AJIOUqDuUdjI7KWb5M0kaigbDDuY5lUR4M
 Pj/8TRmPrAVHUI5mVJNPQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262736>

Hi Junio,

On 2015-01-21 09:54, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>>
>> +	if (starts_with(var, "receive.fsck.")) {
>> +		if (fsck_severity.len)
>> +			strbuf_addch(&fsck_severity, ',');
>> +		strbuf_addf(&fsck_severity, "%s=%s", var + 13, value);
> 
> Wouldn't it be safer to use skip_prefix() that lets you avoid the
> hardcoded "var + 13" here?

Yep, and much more elegant, too. I also fixed three more instances of the same pattern.
 
>> @@ -1470,8 +1478,13 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>>  		argv_array_pushl(&child.args, "unpack-objects", hdr_arg, NULL);
>>  		if (quiet)
>>  			argv_array_push(&child.args, "-q");
>> -		if (fsck_objects)
>> -			argv_array_push(&child.args, "--strict");
>> +		if (fsck_objects) {
>> +			if (fsck_severity.len)
>> +				argv_array_pushf(&child.args, "--strict=%s",
>> +					fsck_severity.buf);
>> +			else
>> +				argv_array_push(&child.args, "--strict");
>> +		}
>>  		child.no_stdout = 1;
>>  		child.err = err_fd;
>>  		child.git_cmd = 1;
>> @@ -1488,8 +1501,13 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>>
>>  		argv_array_pushl(&child.args, "index-pack",
>>  				 "--stdin", hdr_arg, keep_arg, NULL);
>> -		if (fsck_objects)
>> -			argv_array_push(&child.args, "--strict");
>> +		if (fsck_objects) {
>> +			if (fsck_severity.len)
>> +				argv_array_pushf(&child.args, "--strict=%s",
>> +					fsck_severity.buf);
>> +			else
>> +				argv_array_push(&child.args, "--strict");
>> +		}
> 
> Hmm.  The above two hunks look suspiciously similar.  Would it be
> worth to give them a single helper function?

Hmm. Not sure. I see what you mean, but for now I found

+                       argv_array_pushf(&child.args, "--strict%s%s",
+                               fsck_severity.len ? "=" : "",
+                               fsck_severity.buf);

to be more elegant than to add a fully-fledged new function. But if you feel strongly, I will gladly implement a separate function; I would appreciate suggestions as to the function name...

Ciao,
Dscho
