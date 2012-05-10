From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] notes: only append a blob to a blob
Date: Thu, 10 May 2012 11:45:19 -0400
Message-ID: <20120510154519.GB23941@sigill.intra.peff.net>
References: <1336658701-9004-5-git-send-email-pclouds@gmail.com>
 <1336661015-14149-1-git-send-email-pclouds@gmail.com>
 <20120510151904.GB20639@sigill.intra.peff.net>
 <CACsJy8ADE1PBYsQcJnO6U4OFoWQjaEW7=6=3V_UO=t5KNinDCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 17:45:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSVYe-00061e-4H
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab2EJPpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 11:45:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38876
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755242Ab2EJPpV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 11:45:21 -0400
Received: (qmail 30264 invoked by uid 107); 10 May 2012 15:45:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 11:45:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 11:45:19 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8ADE1PBYsQcJnO6U4OFoWQjaEW7=6=3V_UO=t5KNinDCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197588>

On Thu, May 10, 2012 at 10:31:23PM +0700, Nguyen Thai Ngoc Duy wrote:

> >> +static const char *type_name(enum object_type type)
> >> +{
> >> + =C2=A0 =C2=A0 switch (type) {
> >> + =C2=A0 =C2=A0 case OBJ_BLOB: return _("a blob");
> >> + =C2=A0 =C2=A0 case OBJ_TAG: return _("a tag");
> >> + =C2=A0 =C2=A0 case OBJ_COMMIT: return _("a commit");
> >> + =C2=A0 =C2=A0 case OBJ_TREE: return _("a tree");
> >> + =C2=A0 =C2=A0 default:
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("BUG: put a new st=
ring for type %d here", type);
> >> + =C2=A0 =C2=A0 }
> >> +}
> >
> > Don't we have object.c:typename for this
>=20
> The key difference here is _() with an article. It's i18n friendly. I
> wanted to make 15 combinations (blob/blob cannot happen) of "cannot
> append %s to %s", which is best for translators but probably too much
> for C developers.

I do not pay much attention to the translation details, but I would
think that we would keep terms like "tree" and "blob" universal, as the=
y
are technical terms. IOW, you would not expect the "blob" in "git
cat-file blob $sha1" to be internationalized, and this seems like the
same level of technical detail.

> >> @@ -204,8 +216,12 @@ static void create_note(const unsigned char *=
object, struct msg_arg *msg,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_grow(&(msg=
->buf), size + 1);
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg->buf.len =
&& prev_buf && size)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 strbuf_insert(&(msg->buf), 0, "\n", 1);
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prev_buf && size)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prev_buf && size) =
{
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (type !=3D OBJ_BLOB || msg->type !=3D OBJ_BLOB)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("cannot append %s to %s"),
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type_name(type), type_nam=
e(msg->type));
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 strbuf_insert(&(msg->buf), 0, prev_buf, size);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> >
> > I think this is wrong for the reasons above. You would not want to
> > concatenate a tree to a tree.
>=20
> Hmm.. that would become "if (tree !=3D blob || tree !=3D blob) die();=
",
> exactly your point.

Oh, I totally misread this as "type !=3D msg->type" for some reason.
Sorry.

I think the behavior is correct, but the message confused me. If I see
"cannot append a foo to a bar", it implies to me that it is the
combination of the elements that is the limiting factor. But it is not.
It is that one (or more) of the elements is not a blob, regardless of
what the other element is. So I think this would be more accurate:

  if (type !=3D OBJ_BLOB)
          die(_("cannot append to a non-blob note"));
  if (msg->type !=3D OBJ_BLOB)
          die(_("cannot append a non-blob object to a note"));

-Peff
