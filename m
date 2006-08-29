From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why do base objects appear behind the delta in packs?
Date: Tue, 29 Aug 2006 10:34:16 -0700
Message-ID: <7v8xl7moo7.fsf@assigned-by-dhcp.cox.net>
References: <20060829134233.GA21335@spearce.org> <ed1kn3$c3r$1@sea.gmane.org>
	<20060829162747.GA21729@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 19:34:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI7T7-0004Jr-LL
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 19:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWH2Rdb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 29 Aug 2006 13:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWH2Rdb
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 13:33:31 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:34020 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965175AbWH2Rda convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 13:33:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060829173329.TGKM4015.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Tue, 29 Aug 2006 13:33:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FtZR1V00s1kojtg0000000
	Tue, 29 Aug 2006 13:33:25 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060829162747.GA21729@spearce.org> (Shawn Pearce's message of
	"Tue, 29 Aug 2006 12:27:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26209>

Shawn Pearce <spearce@spearce.org> writes:

>> Shawn Pearce wrote:
>>=20
>> > From a data locality perspective putting the base object before
>> > or after the delta shouldn't matter, as either way the delta
>> > is useless without the base. =A0So placing the base immediately
>> > before the delta should perform just as well as placing it after.
>> > Either way the OS should have the base in cache by the time the
>> > delta is being accessed.
>...=20
> I'm going to shutup now and not say anything further on the subject
> unless I've got some hard results indicating a different organization
> is better or worse than what we have right now.

I think that may be a sensible thing to do (no sarcasm -- I
think this measurement is long overdue).

The code was initially proposed just like you suggested but is
in the current form precisely for the reason of avoiding
back-seek.  I distinctly remember me asking Linus "does mmap()
favor forward scan by doing readahead?  I thought its point was
to allow random access" (the answer is "yes" and "yes but
forward is the common case").

The pack-using side in sha1_file.c used to read deltified object
(both header and delta) in full, pick up and read base, and
apply delta to base.  This was thought to be memory hungry on a
longer delta chain, so the current code reads only the header of
a deltified object, reads base, then reads the delta to apply.
The last step involves seeking back, and might make the
back-seek avoidance less effective than before.
