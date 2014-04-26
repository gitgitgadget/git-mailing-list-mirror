From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sat, 26 Apr 2014 09:48:14 +0200
Message-ID: <87wqec8rb5.fsf@fencepost.gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 09:48:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdxLt-0006Qn-O8
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 09:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbaDZHs0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 03:48:26 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:33073 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbaDZHsZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 03:48:25 -0400
Received: from localhost ([127.0.0.1]:60348 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WdxLU-0007oT-Cw; Sat, 26 Apr 2014 03:48:24 -0400
Received: by lola (Postfix, from userid 1000)
	id 3249CE064D; Sat, 26 Apr 2014 09:48:14 +0200 (CEST)
In-Reply-To: <CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
	(Shawn Pearce's message of "Fri, 25 Apr 2014 17:53:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247149>

Shawn Pearce <spearce@spearce.org> writes:

> On Fri, Apr 25, 2014 at 4:56 PM, David Kastrup <dak@gnu.org> wrote:
>> The previous implementation used a single sorted linear list of blam=
e
>> entries for organizing all partial or completed work.  Every subtask=
 had
>> to scan the whole list, with most entries not being relevant to the
>> task.  The resulting run-time was quadratic to the number of separat=
e
>> chunks.
>>
>> This change gives every subtask its own data to work with.  Subtasks=
 are
>> organized into "struct origin" chains hanging off particular commits=
=2E
>> Commits are organized into a priority queue, processing them in comm=
it
>> date order in order to keep most of the work affecting a particular =
blob
>> collated even in the presence of an extensive merge history.
>
> Without reading the code, this sounds like how JGit runs blame.
>
>> For large files with a diversified history, a speedup by a factor of=
 3
>> or more is not unusual.
>
> And JGit was already usually slower than git-core. Now it will be eve=
n
> slower! :-)

If your statement about JGit is accurate, it should likely have beat Gi=
t
for large use cases (where the performance improvements are most
important) as O(n) beats O(n^2) in the long run.

At any rate, I see that I ended up posting this patch series at the end
of the week again which makes for a somewhat lacklustre initial respons=
e
from those who code Git for a regular living.

Apropos: shaking the bugs regarding -M and -C options out of the code
had taken a large toll because -M can cause the same or overlapping lin=
e
regions to be responsible for different target regions and the original
code implementing the "straightforward" blame blew up on the overlap.
I=A0spent a _lot_ of time tracking down that problem.

As I am lousy focusing on more than one task, and as I don't get a
regular paycheck anyway, this will have to remain my last contribution
to Git if I am not going to recoup my losses.

Patch 2 of this series tries giving the community of Git a serious
chance at picking that option (I mean, there are literally millions of
Git users around with a sizable number profiting) while not being
obnoxious about it.

My personal guess is that it will fail regarding both objectives.  But
then I've been surprised before by other free software communities when
trying to make those particular two ends meet.

At any rate, feedback about the performance of the patch from users
disappointed by regular git blame would be welcome.

Apart from the objective measurement of "total time", the more
subjective impression of interactive/incremental response (like in git
gui blame) where the order of results will significantly differ (curren=
t
git-blame --incremental focuses on getting blames resolved in
first-lines-first manner, the proposed git-blame rather works on a
newest-commits-first basis which might better match typical use cases)
might be worth reporting.

--=20
David Kastrup
