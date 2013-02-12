From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] rebase -i: respect core.commentchar
Date: Tue, 12 Feb 2013 09:53:40 +0000
Message-ID: <20130212095340.GG2270@serenity.lan>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
 <20130211213900.GE2270@serenity.lan>
 <7va9raldw8.fsf@alter.siamese.dyndns.org>
 <20130211230804.GF2270@serenity.lan>
 <7vehgmjsno.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 10:54:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5CZ6-0006xh-Cw
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 10:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab3BLJxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 04:53:52 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:58251 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab3BLJxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 04:53:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A3798CDA330;
	Tue, 12 Feb 2013 09:53:50 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tuHQ7jXZPTIZ; Tue, 12 Feb 2013 09:53:48 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 63625CDA5D2;
	Tue, 12 Feb 2013 09:53:42 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vehgmjsno.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216128>

On Mon, Feb 11, 2013 at 04:13:31PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > @@ -179,7 +182,9 @@ die_abort () {
> >  }
> >  
> >  has_action () {
> > -	sane_grep '^[^#]' "$1" >/dev/null
> > +	echo "space stripped actions:" >&2
> > +	git stripspace --strip-comments <"$1" >&2
> > +	test -n "$(git stripspace --strip-comments <"$1")"
> >  }
> 
> I'll remove the debugging remnants while queuing.

Thanks.  I don't think I was fully awake when I finished this last
night - the following fixup is also needed to avoid relying on the shell
emitting a literal backslash when a backslash isn't followed by a known
escape character.

-- >8 --

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index cbe36bf..84bd525 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -947,7 +947,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test_when_finished "git config --unset core.commentchar" &&
 	cat >comment-lines.sh <<EOF &&
 #!$SHELL_PATH
-sed -e "2,\$ s/^/\\\\\\/" "\$1" >"\$1".tmp
+sed -e "2,\$ s/^/\\\\\\\\/" "\$1" >"\$1".tmp
 mv "\$1".tmp "\$1"
 EOF
 	chmod a+x comment-lines.sh &&

-- >8 --

> > @@ -942,20 +948,18 @@ test -s "$todo" || echo noop >> "$todo"
> >  test -n "$autosquash" && rearrange_squash "$todo"
> >  test -n "$cmd" && add_exec_commands "$todo"
> >  
> > -cat >> "$todo" << EOF
> > -
> > -# Rebase $shortrevisions onto $shortonto
> > -EOF
> > +echo >>"$todo"
> > +printf '%s\n' "$comment_char Rebase $shortrevisions onto $shortonto" >>"$todo"
> 
> I think you can still do
> 
> 	cat >>"$todo" <<EOF
> 
> 	$comment_char Rebase $shortrevisions onto...
> 	EOF
> 
> here with any funny comment character.  Doing this with two separate
> I/O does not hurt very much, but the resulting code may be easier to
> scan if left as here-text with a single cat.
> 
> Please eyeball what is in 'pu' (I have a separate squashable fixup
> on top of your patch) and let me know if I made mistakes.

The fixup commit looks good to me.


John
