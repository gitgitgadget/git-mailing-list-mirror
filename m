From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: display first bad commit without forking a new process
Date: Wed, 27 May 2009 15:38:05 -0700
Message-ID: <7veiuai33m.fsf@alter.siamese.dyndns.org>
References: <20090527052354.3824.22018.chriscool@tuxfamily.org>
	<200905272107.52095.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu May 28 00:38:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RlF-0006k3-1h
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801AbZE0WiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 18:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754401AbZE0WiG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:38:06 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59541 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbZE0WiF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:38:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090527223806.TQDJ17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 May 2009 18:38:06 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id wme51b00G4aMwMQ04me50R; Wed, 27 May 2009 18:38:05 -0400
X-Authority-Analysis: v=1.0 c=1 a=PuJ6MZPdszgA:10 a=QAs3T6ytnZkA:10
 a=dIu3SnmMAAAA:8 a=FnhqwwBEuQ9BXcgAEuUA:9 a=ARxfPxoGjHpbmsSOT0AA:7
 a=k5NkVRchaPI4bB4w0oofseNX2ckA:4 a=Rn8qiON8_f4A:10
X-CM-Score: 0.00
In-Reply-To: <200905272107.52095.chriscool@tuxfamily.org> (Christian Couder's message of "Wed\, 27 May 2009 21\:07\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120126>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le Wednesday 27 May 2009, Christian Couder a =C3=A9crit :
>> Previously "git diff-tree --pretty COMMIT" was run using
>> "run_command_v_opt" to display information about the first bad
>> commit.
>>
>> The goal of this patch is to avoid a "fork" and an "exec" call
>> when displaying that information.
>>
>> To do that, we manually setup revision information as
>> "git diff-tree --pretty" would do it, and then use the
>> "log_tree_commit" function.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  bisect.c |   30 +++++++++++++++++++++++++++---
>>  1 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/bisect.c b/bisect.c
>> index c43c120..e94a77b 100644
>> --- a/bisect.c
>> +++ b/bisect.c
>> @@ -816,6 +816,31 @@ static void check_good_are_ancestors_of_bad(con=
st
>> char *prefix) }
>>
>>  /*
>> + * This does "git diff-tree --pretty COMMIT" without one fork+exec.
>> + */
>> +static void show_diff_tree(const char *prefix, struct commit *commi=
t)
>> +{
>> +	static struct rev_info opt;
>
> Oops, "static" can be removed, it's a copy-paste error, sorry.

Is that "can" or "must"?  If the answer is the latter, shouldn't the
function be renamed to make it clear it is a bisect specific thing?
