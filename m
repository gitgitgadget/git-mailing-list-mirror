From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 00/34] libify mailinfo and call it directly from am
Date: Wed, 21 Oct 2015 16:51:50 +0100
Message-ID: <5627B496.7030102@ramsayjones.plus.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
 <xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 17:52:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZovgF-0007NB-F1
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 17:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbbJUPvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 11:51:55 -0400
Received: from avasout08.plus.net ([212.159.14.20]:52548 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbbJUPvx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 11:51:53 -0400
Received: from [10.0.2.15] ([87.114.3.134])
	by avasout08 with smtp
	id Xrrq1r0062tV80P01rrrjV; Wed, 21 Oct 2015 16:51:52 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=qQ71F3v+nKp5qei/W0vv8w==:117 a=qQ71F3v+nKp5qei/W0vv8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=N659UExz7-8A:10 a=ybZZDoGAAAAA:8 a=uAZz7aE3vrr3dzCqkp4A:9
 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279985>



On 20/10/15 22:24, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> During the discussion on the recent "git am" regression, I noticed
>> that the command reimplemented in C spawns one "mailsplit" and then
>> spawns "mailinfo" followed by "apply --index" to commit the changes
>> described in each message.  As there are platforms where spawning
>> subprocess via run_command() interface is heavy-weight, something
>> that is conceptually very simple like "mailinfo" is better called
>> directly inside the process---something that is lightweight and
>> frequently used is where the overhead of run_command() would be felt
>> most.
> 
> Although I still haven't seen any offer to help from those who work
> on the platforms that may benefit from this series the most, I have
> some numbers on my desktop (Dell T3500 2.66GHz Xeon X5650 with 12GB,
> running Ubuntu), where the cost of spawning is not as costly as
> elsewhere, making this series less pressing.

I suspect that I haven't tested exactly the same version as you, but I had
a quick look at testing this on Cygwin today. I have included a complete
transcript (below), so you can see what I did wrong! :-P

> 
> Between 'master' and the version with this series (on 'jch'),
> applying this 34-patch series itself on top of 'master' using "git
> am", best of 5 numbers for running:
> 
>     time git am mbox >/dev/null
> 
> are
> 
>       (master)                 (with the series)
>     real    0m0.648s            real    0m0.537s
>     user    0m0.358s            user    0m0.338s
>     sys     0m0.172s            sys     0m0.154s
> 

The corresponding times for me were:

    (master)           (with the series)
  real	0m9.760s      real	0m5.744s
  user	0m0.531s      user	0m0.656s
  sys	0m5.726s      sys	0m3.520s

So, yes, a noticeable improvement! :)

HTH

ATB,
Ramsay Jones

  $ uname -a
  CYGWIN_NT-6.3 satellite 2.2.1(0.289/5/3) 2015-08-20 11:42 x86_64 Cygwin
  $ pwd
  /home/ramsay/git
  $ git log --decorate --oneline -1
  74301d6 (HEAD -> master, origin/master, origin/HEAD) Sync with maint
  $ ./git version
  git version 2.6.2.280.g74301d6
  $ git format-patch --stdout 2a5ce7c^..896df93 >mailinfo.mbox
  $ git format-patch --stdout a4106a8^..559e247 >>mailinfo.mbox
  $ git checkout -b master-mailinfo master
  Switched to a new branch 'master-mailinfo'
  $ time ./git am mailinfo.mbox
  Applying: mailinfo: remove a no-op call convert_to_utf8(it, "")
  Applying: mailinfo: fold decode_header_bq() into decode_header()
  Applying: mailinfo: fix an off-by-one error in the boundary stack
  Applying: mailinfo: explicitly close file handle to the patch output
  Applying: mailinfo: move handle_boundary() lower
  Applying: mailinfo: get rid of function-local static states
  Applying: mailinfo: do not let handle_body() touch global "line" directly
  Applying: mailinfo: do not let handle_boundary() touch global "line" directly
  Applying: mailinfo: do not let find_boundary() touch global "line" directly
  Applying: mailinfo: move global "line" into mailinfo() function
  Applying: mailinfo: introduce "struct mailinfo" to hold globals
  Applying: mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
  Applying: mailinfo: move global "FILE *fin, *fout" to struct mailinfo
  Applying: mailinfo: move filter/header stage to struct mailinfo
  Applying: mailinfo: move patch_lines to struct mailinfo
  Applying: mailinfo: move add_message_id and message_id to struct mailinfo
  Applying: mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
  Applying: mailinfo: move metainfo_charset to struct mailinfo
  Applying: mailinfo: move check for metainfo_charset to convert_to_utf8()
  Applying: mailinfo: move transfer_encoding to struct mailinfo
  Applying: mailinfo: move charset to struct mailinfo
  Applying: mailinfo: move cmitmsg and patchfile to struct mailinfo
  Applying: mailinfo: move [ps]_hdr_data to struct mailinfo
  Applying: mailinfo: move content/content_top to struct mailinfo
  Applying: mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
  Applying: mailinfo: keep the parsed log message in a strbuf
  Applying: mailinfo: move read_one_header_line() closer to its callers
  Applying: mailinfo: move check_header() after the helpers it uses
  Applying: mailinfo: move cleanup_space() before its users
  Applying: mailinfo: move definition of MAX_HDR_PARSED closer to its use
  Applying: mailinfo: libify
  Applying: mailinfo: handle charset conversion errors in the caller
  Applying: mailinfo: remove calls to exit() and die() deep in the callchain
  Applying: am: make direct call to mailinfo
  Applying: mailinfo: plug strbuf leak during continuation line handling
  
  real	0m9.760s
  user	0m0.531s
  sys	0m5.726s
  $ 
  
  $ make clean >/dev/null 2>&1
  $ make >out.mi 2>&1
  $ ./git version
  git version 2.6.2.315.g1e9f6ff
  $ git describe
  v2.6.2-315-g1e9f6ff
  $ git checkout -b new-mailinfo master
  Switched to a new branch 'new-mailinfo'
  $ time ./git am mailinfo.mbox
  Applying: mailinfo: remove a no-op call convert_to_utf8(it, "")
  Applying: mailinfo: fold decode_header_bq() into decode_header()
  Applying: mailinfo: fix an off-by-one error in the boundary stack
  Applying: mailinfo: explicitly close file handle to the patch output
  Applying: mailinfo: move handle_boundary() lower
  Applying: mailinfo: get rid of function-local static states
  Applying: mailinfo: do not let handle_body() touch global "line" directly
  Applying: mailinfo: do not let handle_boundary() touch global "line" directly
  Applying: mailinfo: do not let find_boundary() touch global "line" directly
  Applying: mailinfo: move global "line" into mailinfo() function
  Applying: mailinfo: introduce "struct mailinfo" to hold globals
  Applying: mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
  Applying: mailinfo: move global "FILE *fin, *fout" to struct mailinfo
  Applying: mailinfo: move filter/header stage to struct mailinfo
  Applying: mailinfo: move patch_lines to struct mailinfo
  Applying: mailinfo: move add_message_id and message_id to struct mailinfo
  Applying: mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
  Applying: mailinfo: move metainfo_charset to struct mailinfo
  Applying: mailinfo: move check for metainfo_charset to convert_to_utf8()
  Applying: mailinfo: move transfer_encoding to struct mailinfo
  Applying: mailinfo: move charset to struct mailinfo
  Applying: mailinfo: move cmitmsg and patchfile to struct mailinfo
  Applying: mailinfo: move [ps]_hdr_data to struct mailinfo
  Applying: mailinfo: move content/content_top to struct mailinfo
  Applying: mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
  Applying: mailinfo: keep the parsed log message in a strbuf
  Applying: mailinfo: move read_one_header_line() closer to its callers
  Applying: mailinfo: move check_header() after the helpers it uses
  Applying: mailinfo: move cleanup_space() before its users
  Applying: mailinfo: move definition of MAX_HDR_PARSED closer to its use
  Applying: mailinfo: libify
  Applying: mailinfo: handle charset conversion errors in the caller
  Applying: mailinfo: remove calls to exit() and die() deep in the callchain
  Applying: am: make direct call to mailinfo
  Applying: mailinfo: plug strbuf leak during continuation line handling
  
  real	0m5.744s
  user	0m0.656s
  sys	0m3.520s
  $ 

  $ git rev-parse master-mailinfo^{tree} new-mailinfo^{tree}
  cebb1a110f3af9f4393bb66b942ae28e2743f233
  cebb1a110f3af9f4393bb66b942ae28e2743f233
  $ 
