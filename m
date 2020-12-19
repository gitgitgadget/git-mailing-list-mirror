Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5594DC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 10:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A2623B84
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 10:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgLSKWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 05:22:03 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:40908 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgLSKWC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 05:22:02 -0500
Received: from client3368.fritz.box (i5C745FEF.versanet.de [92.116.95.239])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 3E2593C01D9;
        Sat, 19 Dec 2020 11:21:17 +0100 (CET)
Subject: Re: [PATCH v2] gitk: Add options --select-file and --select-line
From:   Stefan Haller <stefan@haller-berlin.de>
To:     paulus@ozlabs.org
Cc:     git@vger.kernel.org
References: <CAPig+cSRX+5o645fxBZunm4hiBM-1Gr8jChijyUNgNkO1wHKdA@mail.gmail.com>
 <20201015073138.50899-1-stefan@haller-berlin.de>
 <6d6068cd-6f0d-cb1e-4a4b-ba1a2a562d5e@haller-berlin.de>
Message-ID: <bd940f73-ca2f-fe21-ea0a-fcd5f40af683@haller-berlin.de>
Date:   Sat, 19 Dec 2020 11:21:16 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <6d6068cd-6f0d-cb1e-4a4b-ba1a2a562d5e@haller-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.11.20 10:24, Stefan Haller wrote:
> On 15.10.20 9:31, Stefan Haller wrote:
>> These can be used in combination with --select-commit to jump to a given
>> line in a patch on startup. (They don't have any effect when
>> --select-commit is not used.)
>>
>> This is useful for the "Show History Context" command in Git Gui's blame
>> window, which currently only jumps to the right commit in gitk, but
>> doesn't select the line that the context menu was opened on.
>>
>> Also, these options allow for powerful editor integration; they make it
>> possible to jump into gitk right from a text editor. For example, here's
>> a small ruby script that takes a file path and a line number and opens
>> gitk with the commit selected that last modified that line. This can
>> easily be mapped to a key in vim or other editors.
> 
> Just a gentle ping. Any thoughts?
> 
> I have been running with this patch for a few years now, and I use the
> functionality daily. I'd love to get this applied so that I don't have
> to maintain this patch locally. Also, my co-workers are jealous every
> time they see what I can do with this. :-)
> 
> Thanks, Stefan.

Another friendly ping; it's been two months since I submitted the patch.
Is there anything else I can do to get this included?

Thanks, Stefan.

>>
>>     #!/usr/bin/env ruby
>>
>>     if ARGV.length != 2
>>         puts "Usage: #{$0} <file> <line>"
>>         exit 1
>>     end
>>
>>     file, line = ARGV
>>     blame_output = `git blame -p -L#{line},+1 "#{file}"`
>>     exit 1 if $?.exitstatus != 0
>>
>>     blame_output_lines = blame_output.split("\n")
>>     commit, line = blame_output_lines[0].split
>>
>>     file = blame_output_lines.grep(/^filename /)[0][9..-1]
>>     date = blame_output_lines.grep(/^committer-time /)[0][15..-1]
>>     two_weeks_later = date.to_i + 60 * 60 * 24 * 7 * 2
>>
>>     system "gitk --before='#{two_weeks_later}' \
>>                  --select-commit=#{commit} \
>>                  --select-file='#{file}' \
>>                  --select-line=#{line} &"
>>
>> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
>> ---
>> Second version: added Signed-off-by. No other changes.
>>
>>  gitk | 31 ++++++++++++++++++++++++++++---
>>  1 file changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/gitk b/gitk
>> index 23d9dd1..cf70313 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -475,12 +475,17 @@ proc stop_rev_list {view} {
>>  }
>>
>>  proc reset_pending_select {selid} {
>> -    global pending_select mainheadid selectheadid
>> +    global pending_select pending_select_file pending_select_line
>> +    global mainheadid selectheadid select_file select_line
>>
>>      if {$selid ne {}} {
>>          set pending_select $selid
>>      } elseif {$selectheadid ne {}} {
>>          set pending_select $selectheadid
>> +        if {$select_file ne {} && $select_line ne {}} {
>> +            set pending_select_file $select_file
>> +            set pending_select_line $select_line
>> +        }
>>      } else {
>>          set pending_select $mainheadid
>>      }
>> @@ -1612,6 +1617,16 @@ proc getcommitlines {fd inst view updating}  {
>>      return 2
>>  }
>>
>> +proc select_pending_line {} {
>> +    global pending_select pending_select_file pending_select_line
>> +
>> +    set desired_loc [expr {[info exists pending_select_file]
>> +        ? [list $pending_select_file $pending_select_line]
>> +        : {}}]
>> +
>> +    selectline [rowofcommit $pending_select] 1 $desired_loc
>> +}
>> +
>>  proc chewcommits {} {
>>      global curview hlview viewcomplete
>>      global pending_select
>> @@ -1626,7 +1641,7 @@ proc chewcommits {} {
>>              reset_pending_select {}
>>
>>              if {[commitinview $pending_select $curview]} {
>> -                selectline [rowofcommit $pending_select] 1
>> +                select_pending_line
>>              } else {
>>                  set row [first_real_row]
>>                  selectline $row 1
>> @@ -5244,7 +5259,7 @@ proc layoutmore {} {
>>      if {[info exists pending_select] &&
>>          [commitinview $pending_select $curview]} {
>>          update
>> -        selectline [rowofcommit $pending_select] 1
>> +        select_pending_line
>>      }
>>      drawvisible
>>  }
>> @@ -7325,6 +7340,8 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
>>      global vinlinediff
>>
>>      unset -nocomplain pending_select
>> +    unset -nocomplain pending_select_file
>> +    unset -nocomplain pending_select_line
>>      $canv delete hover
>>      normalline
>>      unsel_reflist
>> @@ -12507,6 +12524,8 @@ if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
>>
>>  set selecthead {}
>>  set selectheadid {}
>> +set select_file {}
>> +set select_line {}
>>
>>  set revtreeargs {}
>>  set cmdline_files {}
>> @@ -12522,6 +12541,12 @@ foreach arg $argv {
>>          "--select-commit=*" {
>>              set selecthead [string range $arg 16 end]
>>          }
>> +        "--select-file=*" {
>> +            set select_file [string range $arg 14 end]
>> +        }
>> +        "--select-line=*" {
>> +            set select_line [string range $arg 14 end]
>> +        }
>>          "--argscmd=*" {
>>              set revtreeargscmd [string range $arg 10 end]
>>          }
>> --
>> 2.29.0.rc1.13.g3b7fca9674
>>
