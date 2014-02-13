From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: add option to omit newlines
Date: Thu, 13 Feb 2014 12:10:33 -0800
Message-ID: <xmqq38jmlqo6.fsf@gitster.dls.corp.google.com>
References: <1392314429-15281-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 21:10:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE2cO-0008EW-VS
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 21:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbaBMUKj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Feb 2014 15:10:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaBMUKi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Feb 2014 15:10:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C34376CE24;
	Thu, 13 Feb 2014 15:10:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nFspTo73cC0t
	lCs5Bdety7Ep+Mc=; b=sLLPicPlmzpvAZm03tCCMd9ejpuauHQ0vlryh/khkI2l
	ZzU9/ZH00PkgeuDn7tKtPChbqmEhgMKv04X+lSiEYkkViyf9Xb3BzH0qKR6zQ4xd
	w7NTpjp0Kxtm0+6XY+9H/fMfDuICdJn/d7yigBV6Ba95bYTuq3brXHBpdNd1iCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N9TP9A
	KjBBWkBKbx9eAlOEdtawGSH+Dt1PKtlMe3dPq6FqIdSNxmQuWuxYMSKaRkoLdI9k
	93Qf3BR5OGlbT+/2tZi4DEXoSl0cjRZIQ1jkqfy2nf5OOaeKjbno6sgQ7cT7hJ5O
	ggO2DmsLKWtFVSJ/Edxpdqhln70uPrAcmk4S8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A06A06CE22;
	Thu, 13 Feb 2014 15:10:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0D606CE1F;
	Thu, 13 Feb 2014 15:10:36 -0500 (EST)
In-Reply-To: <1392314429-15281-1-git-send-email-oystwa@gmail.com>
 (=?utf-8?Q?=22=C3=98ystein?=
	Walle"'s message of "Thu, 13 Feb 2014 19:00:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E6E0999E-94EA-11E3-B3A4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242077>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> On to the patch itself: I contemplated putting '\n' in the default fo=
rmat and
> removing it if -n was given, which would get rid of the need to pass =
an exta
> argument to show_ref(). But that means we would need to *insert it* w=
hen a
> format is given and -n is not...

I would rather see us go in the direction to add "-z" output option,
which is what everybody else that produces NUL terminated entries in
our suite of subcommands does.

IOW, something along with this line (untested).

 builtin/for-each-ref.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 51798b4..2c8cac8 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -94,6 +94,7 @@ static const char **used_atom;
 static cmp_type *used_atom_type;
 static int used_atom_cnt, need_tagged, need_symref;
 static int need_color_reset_at_eol;
+static int line_termination =3D '\n';
=20
 /*
  * Used to parse format string and sort specifiers
@@ -1023,7 +1024,7 @@ static void show_ref(struct refinfo *info, const =
char *format, int quote_style)
 		resetv.s =3D color;
 		print_value(&resetv, quote_style);
 	}
-	putchar('\n');
+	putchar(line_termination);
 }
=20
 static struct ref_sort *default_sort(void)
@@ -1088,6 +1089,9 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use =
for the output")),
 		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
 			    N_("field name to sort on"), &opt_parse_sort),
+		OPT_SET_INT('z', NULL, &line_termination,
+			    N_("Use NUL instead of LF to end each output records"),
+			    '\0'),
 		OPT_END(),
 	};
=20
