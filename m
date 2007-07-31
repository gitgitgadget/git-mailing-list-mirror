From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] Split out the actual commit creation from the option parsing etc.
Date: Mon, 30 Jul 2007 21:43:19 -0700
Message-ID: <7v8x8xgp3s.fsf@assigned-by-dhcp.cox.net>
References: <11858309261111-git-send-email-krh@redhat.com>
	<11858309311728-git-send-email-krh@redhat.com>
	<11858309322006-git-send-email-krh@redhat.com>
	<11858309322915-git-send-email-krh@redhat.com>
	<11858309332705-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 06:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFja6-0000D6-OT
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 06:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934092AbXGaEnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 00:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbXGaEnY
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 00:43:24 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:44005 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757622AbXGaEnW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 00:43:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070731044322.KJOY14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 31 Jul 2007 00:43:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W4jM1X00T1kojtg0000000; Tue, 31 Jul 2007 00:43:22 -0400
In-Reply-To: <11858309332705-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Mon, 30 Jul 2007 17:28:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54322>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> @@ -85,40 +129,20 @@ int cmd_commit_tree(int argc, const char **argv,=
 const char *prefix)
>  			parents++;
>  	}
> =20
> -	/* Not having i18n.commitencoding is the same as having utf-8 */
> -	encoding_is_utf8 =3D is_encoding_utf8(git_commit_encoding);
> +	buffer =3D NULL;
> +	if (read_fd(0, &buffer, &len))
> +		die("Could not read commit message from standard input");
> =20
> -	strbuf_init(&sb);
> -	strbuf_printf(&sb, "tree %s\n", sha1_to_hex(tree_sha1));
> +	commit_sha1 =3D create_commit(tree_sha1,
> +				    parent_sha1, parents,
> +				    xstrdup(git_author_info(1)),
> +				    xstrdup(git_committer_info(1)),
> +				    buffer, len);

Hmph, the series was so nice so far, but here we have a few new
leak, presumably so small per process invocation that we do not
care about?
