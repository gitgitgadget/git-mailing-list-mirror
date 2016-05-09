From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Tue, 10 May 2016 00:46:50 +0100
Message-ID: <5731216A.7080808@ramsayjones.plus.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
 <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
 <1462832134.24478.49.camel@twopensource.com>
 <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
 <xmqqtwi6svzx.fsf@gitster.mtv.corp.google.com>
 <1462835573.24478.53.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 01:47:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azutA-0004pP-Py
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 01:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbcEIXq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 19:46:56 -0400
Received: from avasout08.plus.net ([212.159.14.20]:46575 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbcEIXqz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 19:46:55 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id sPmr1s0032D2Veb01PmsKz; Tue, 10 May 2016 00:46:53 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=ybZZDoGAAAAA:8 a=6NG_XSeZAAAA:8 a=xhqh43RNEVDilyM3ApkA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=GJ3Te8GUQ8bK2C1KGtqm:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <1462835573.24478.53.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294083>



On 10/05/16 00:12, David Turner wrote:
> On Mon, 2016-05-09 at 15:32 -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> David Turner <dturner@twopensource.com> writes:
>>>
>>>> On Mon, 2016-05-09 at 14:40 -0700, Junio C Hamano wrote:
>>>>> Hmmm, I seem to be getting
>>>>>
>>>>>     $ cat t/trash*7900*/err
>>>>>     fatal: Already running
>>>>>
>>>>> after running t7900 and it fails at #5, after applying
>>>>> "index-helper: optionally automatically run"
>>
>> The symptom looks pretty similar to $gmane/293461 reported earlier.
>> Here is how "t7900-index-helper.sh -i -v -x -d" ends.
>>
>>
>> expecting success:
>>         test_when_finished "git index-helper --kill" &&
>>         rm -f .git/index-helper.sock &&
>>         git status &&
>>         test_path_is_missing .git/index-helper.sock &&
>>         test_config indexhelper.autorun true &&
>>         git status &&
>>         test -S .git/index-helper.sock &&
>>         git status 2>err &&
>>         test -S .git/index-helper.sock &&
>>         test_must_be_empty err &&
>>         git index-helper --kill &&
>>         test_config indexhelper.autorun false &&
>>         git status &&
>>         test_path_is_missing .git/index-helper.sock
>>
>> + test_when_finished git index-helper --kill
>> + test 0 = 0
>> + test_cleanup={ git index-helper --kill
>>                 } && (exit "$eval_ret"); eval_ret=$?; :
>> + rm -f .git/index-helper.sock
>> + git status
>> On branch master
>> Untracked files:
>>   (use "git add <file>..." to include in what will be committed)
>>
>>         err
>>
>> nothing added to commit but untracked files present (use "git add" to
>> track)
>> + test_path_is_missing .git/index-helper.sock
>> + test -e .git/index-helper.sock
>> + test_config indexhelper.autorun true
>> + config_dir=
>> + test indexhelper.autorun = -C
>> + test_when_finished test_unconfig  'indexhelper.autorun'
>> + test 0 = 0
>> + test_cleanup={ test_unconfig  'indexhelper.autorun'
>>                 } && (exit "$eval_ret"); eval_ret=$?; { git index
>> -helper --kill
>>                 } && (exit "$eval_ret"); eval_ret=$?; :
>> + git config indexhelper.autorun true
>> + git status
>> error: last command exited with $?=141
> 
> I think that's a SIGPIPE on the first git status.  Weird, since I just
> added sigpipe-avoidance code (in v8).  Does anyone have any idea why
> the sigchain stuff isn't doing what I think it is?

Sorry for a late report (I've been a bit busy last couple of days), but
I've been seeing exactly the same on v8 of this series.

Note that the above 'git status' is actually the second git-status in the
test.

I haven't been able to debug it too much, but I can tell you that it is
not failing at exactly the same place every time (so it may be time
sensitive). However, it often fails in poke_and_wait_for_reply() at the
first packet_flush() (which in turn calls write_or_die()  which calls
check_pipe() with an EPIPE(32)). At other times it fails when issuing
a flush after a refresh packet. For example, on one run with packet
tracing enabled, I got this for the trace:

  trace: built-in: git 'status'
  packet:          git> poke 3221 
  packet:          git> 0000
  packet:          git< OK
  packet:          git> refresh
  packet:          git> 0000

So, its getting the EPIPE for the refresh in this case, even though
the index-helper is still running, the unix socket is in .git/
(and so is a shm-* file BTW).

I didn't get any further than that I'm afraid.

ATB,
Ramsay Jones
