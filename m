From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] gc: save log from daemonized gc --auto and print it next time
Date: Mon, 14 Sep 2015 10:37:08 -0700
Message-ID: <xmqq1te0ykaj.fsf@gitster.mtv.corp.google.com>
References: <1440209546-23442-1-git-send-email-pclouds@gmail.com>
	<1442108202-25746-1-git-send-email-pclouds@gmail.com>
	<xmqq8u88ykv4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:37:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXgr-0001h1-WF
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbbINRhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 13:37:11 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33880 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbbINRhK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:37:10 -0400
Received: by padhy16 with SMTP id hy16so149642794pad.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HzGyZntqc8+NMnl+4DpB7YejJ+GydU6w/mQ2EqXc5z8=;
        b=gaWaSa8U845y5x2yFpe6qFPC9iXms/6tgUZQUVqTUGSkYmUXmNRtRTeF8Rt/DUxROR
         66qnhO3ZeU3VOV5E/Ib2PBfZoT4i0NEH+CHTzOlE6v6OCkAi+967/hBAzwdH4XD8n56G
         bDa2TepExcrLNSf08wnqIUd/rTHVaT3IDPR9gI3USDO0w8Bw4Ytf2t5vKJftl1kUDQkh
         VF25rvh0/tj1GGc+jdrMaqDLAWv8pJwSuR1H/uKGOxZI/BDgq0xBr62rWxsXKkccApNJ
         /yWDK4FpwHfvl01oyjECyDTBRcai2HgO3pHhqThBOgatPwyI4AdSFBukyx4Rwjot58qj
         YYFQ==
X-Received: by 10.68.98.5 with SMTP id ee5mr36926698pbb.95.1442252229748;
        Mon, 14 Sep 2015 10:37:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id ff4sm17440333pab.2.2015.09.14.10.37.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 10:37:08 -0700 (PDT)
In-Reply-To: <xmqq8u88ykv4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 14 Sep 2015 10:24:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277849>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks, will queue.

Ehh, I spoke a bit too early.

>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index bcc75d9..2c3aaeb 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -43,9 +43,20 @@ static struct argv_array prune_worktrees = ARGV_ARRAY_INIT;
>>  static struct argv_array rerere = ARGV_ARRAY_INIT;
>>  
>>  static char *pidfile;
>> +static struct strbuf log_filename = STRBUF_INIT;
>> +static int daemonized;
>>  
>>  static void remove_pidfile(void)
>>  {
>> +	if (daemonized && log_filename.len) {
>> +		struct stat st;
>> +
>> +		close(2);
>> +		if (stat(log_filename.buf, &st) ||
>> +		    !st.st_size ||
>> +		    rename(log_filename.buf, git_path("gc.log")))
>> +			unlink(log_filename.buf);
>> +	}

Unfortuantely we cannot queue this as-is, as we let the tempfile API
to automatically manage the pidfile since ebebeaea (gc: use tempfile
module to handle gc.pid file, 2015-08-10), and you cannot piggy-back
the log file finalization to this function that no longer exists.

Besides, it is obviously wrong to remove this log file in a function
whose name is remove_pidfile() ;-)

Adding a new function to tempfile API that puts the file to a final
place if it is non-empty and otherwise remove it, and using that to
create this "gc.log" file, would be the cleanest from the point of
view of _this_ codepath.  I however do not know if that is too
specific for the need of this codepath or "leave it if non-empty,
but otherwise remove as it is uninteresting" is fairly common thing
we would want and it is a good addition to the API set.

Michael, what do you think?

>> @@ -330,13 +341,21 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
>>  		}
>>  		if (detach_auto) {
>> +			struct strbuf sb = STRBUF_INIT;
>> +			if (strbuf_read_file(&sb, git_path("gc.log"), 0) > 0)
>> +				return error(_("last gc run reported:\n"
>> +					       "%s\n"
>> +					       "not running until %s is removed"),
>> +					     sb.buf, git_path("gc.log"));
>> +			strbuf_release(&sb);
>> +
>>  			if (gc_before_repack())
>>  				return -1;
>>  			/*
>>  			 * failure to daemonize is ok, we'll continue
>>  			 * in foreground
>>  			 */
>> -			daemonize();
>> +			daemonized = !daemonize();
>>  		}
>>  	} else
>>  		add_repack_all_option();
>> @@ -349,6 +368,18 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>  		    name, (uintmax_t)pid);
>>  	}
>>  
>> +	if (daemonized) {
>> +		int fd;
>> +
>> +		strbuf_addstr(&log_filename, git_path("gc.log_XXXXXX"));
>> +		fd = xmkstemp(log_filename.buf);
>> +		if (fd >= 0) {
>> +			dup2(fd, 2);
>> +			close(fd);
>> +		} else
>> +			strbuf_release(&log_filename);
>> +	}
>> +
>>  	if (gc_before_repack())
>>  		return -1;
