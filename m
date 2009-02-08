From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Offer to print changes while running git-mergetool
Date: Sun, 08 Feb 2009 01:24:38 +0000
Message-ID: <498E3456.1080509@hashpling.org>
References: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>	 <7vr62ay8dh.fsf@gitster.siamese.dyndns.org> <57518fd10902070401x14cc7cacrfb8bc88bbf2999cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Sun Feb 08 02:26:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVyRa-0003Gv-Bt
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 02:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbZBHBYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 20:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbZBHBYr
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 20:24:47 -0500
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:12146 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699AbZBHBYq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2009 20:24:46 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAHfDjUnUnw6S/2dsb2JhbADMZ4QaBg
Received: from ptb-relay02.plus.net ([212.159.14.146])
  by relay.pcl-ipout02.plus.net with ESMTP; 08 Feb 2009 01:24:44 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1LVyPc-0003cg-FX; Sun, 08 Feb 2009 01:24:44 +0000
Received: from [192.168.76.29] (heisenberg2.hashpling.org [192.168.76.29])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n181Oc6b004467;
	Sun, 8 Feb 2009 01:24:38 GMT
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <57518fd10902070401x14cc7cacrfb8bc88bbf2999cd@mail.gmail.com>
X-Plusnet-Relay: 85422b012d69fd9f361cf83eff152801
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108908>

Jonathan del Strother wrote:
> On Sat, Feb 7, 2009 at 8:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jonathan del Strother <jon.delStrother@bestbefore.tv> writes:
>>
>>> Add a "Show changes" option to each prompt in mergetool. This prints the
>>> conflicted changes on the current file, using 'git log -p --merge
>>> <file>'
>> I think the patch should look like this, given the recent conversation I
>> had with you.  It seems that the script thinks the unit of indentation is
>> 4-places, and case arms are indented from case/esac (neither of which is
>> the standard git shell script convention), and I tried to match that style
>> used in the existing code.
>>
>> No, I didn't test it.
>>
>> Charles volunteered to take over mergetool, so he is on the Cc: list.

At the moment, I'm slightly cool towards this patch, but perhaps I don't
 really understand the underlying issue. I understand wanting to check
something (logs) in the middle of a mergetool run but I can't say that
I've ever wanted to specifically run 'git log -p --merge'. Perhaps some
users of mergetool - being visual people - would more naturally reach
for gitk?

Given that mergetool picks up from where it left off when run a second
time, what does this patch offer over Ctrl-c, run log tool of your
choice, re-run mergetool? Or just running git log in a different
terminal instance?

I've made couple of minor comments on the patch below.

Charles.


>>  git-mergetool.sh |   60 ++++++++++++++++++++++++++++++++++++++++++-----------
>>  1 files changed, 47 insertions(+), 13 deletions(-)
>>
>> diff --git c/git-mergetool.sh w/git-mergetool.sh
>> index 87fa88a..b8604d6 100755
>> --- c/git-mergetool.sh
>> +++ w/git-mergetool.sh
>> @@ -14,6 +14,13 @@ OPTIONS_SPEC=
>>  . git-sh-setup
>>  require_work_tree
>>
>> +if test -f "$GIT_DIR/MERGE_HEAD"
>> +then
>> +    in_merge=t show_changes=", (s)how changes"
>> +else
>> +    in_merge=f show_changes=
>> +fi
>> +
>>  # Returns true if the mode reflects a symlink
>>  is_symlink () {
>>     test "$1" = 120000
>> @@ -62,22 +69,28 @@ describe_file () {
>>
>>  resolve_symlink_merge () {
>>     while true; do

--- snip ---

>>                ;;
>> -           [aA]*)
>> +           t,[sS]*)
>> +               git log -p --merge "$MERGED"
>> +               printf "\n"
>> +               resolve_symlink_merge
>> +               return
>> +               ;;

Slightly unusual recursion, why not just drop out to the 'while true' loop?

>>            esac
>> @@ -87,23 +100,29 @@ resolve_symlink_merge () {
>>  resolve_deleted_merge () {
>>     while true; do

--- snip ---

>>                ;;
>> -           [aA]*)
>> +           t,[sS]*)
>> +               git log -p --merge "$MERGED"
>> +               printf "\n"
>> +               resolve_deleted_merge
>> +               return
>> +               ;;

Resursion as above, but why not fall out to the 'while true' again?

>> @@ -184,8 +203,23 @@ merge_file () {
>>     describe_file "$local_mode" "local" "$LOCAL"
>>     describe_file "$remote_mode" "remote" "$REMOTE"
>>     if "$prompt" = true; then
>> -       printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
>> -       read ans
>> +       while true; do
>> +           case $in_merge in
>> +               t)      msg_head="(S)how changes, or h" ;;
>> +               f)      msg_head="H" ;;
>> +           esac
>> +           print "${msg_head}it return to start merge resolution tool (%s): " "$merge_tool"
>> +           read ans
>> +           case "$in_merge,$ans" in
>> +               t,[sS]*)
>> +                   git log -p --merge "$MERGED"
>> +                   printf "\n"
>> +                   ;;

No recursion here, this feels a but more natural to me.
