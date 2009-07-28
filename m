From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3 v2] Add support for external programs for handling 
 native fetches
Date: Tue, 28 Jul 2009 11:25:57 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907281124060.2147@iabervon.org>
References: <alpine.LNX.2.00.0907280155390.2147@iabervon.org> <36ca99e90907280107i7afb7c64tf0c49bdf82e1e7cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1566878557-1248794757=:2147"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mariano Ortega <mgo1977@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 17:26:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVoZ7-0007F8-OG
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 17:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbZG1PZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 11:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753204AbZG1PZ6
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 11:25:58 -0400
Received: from iabervon.org ([66.92.72.58]:55916 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbZG1PZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 11:25:58 -0400
Received: (qmail 9591 invoked by uid 1000); 28 Jul 2009 15:25:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jul 2009 15:25:57 -0000
In-Reply-To: <36ca99e90907280107i7afb7c64tf0c49bdf82e1e7cb@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124257>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1566878557-1248794757=:2147
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 28 Jul 2009, Bert Wesarg wrote:

> On Tue, Jul 28, 2009 at 08:08, Daniel Barkalow<barkalow@iabervon.org> wrote:
> > +static struct child_process *get_shim(struct transport *transport)
> > +{
> > +       struct shim_data *data = transport->data;
> > +       if (!data->shim) {
> > +               struct strbuf buf = STRBUF_INIT;
> > +               struct child_process *shim = xcalloc(1, sizeof(*shim));
> > +               shim->in = -1;
> > +               shim->out = -1;
> > +               shim->err = 0;
> > +               shim->argv = xcalloc(4, sizeof(*shim->argv));
> > +               strbuf_addf(&buf, "shim-%s", data->name);
> > +               shim->argv[0] = buf.buf;
> > +               shim->argv[1] = transport->remote->name;
> > +               shim->argv[2] = transport->url;
> > +               shim->git_cmd = 1;
> > +               start_command(shim);
> > +               data->shim = shim;
> > +       }
> > +       return data->shim;
> > +}
> > +
> > +static int disconnect_shim(struct transport *transport)
> > +{
> > +       struct shim_data *data = transport->data;
> > +       if (data->shim) {
> > +               write(data->shim->in, "\n", 1);
> > +               close(data->shim->in);
> > +               finish_command(data->shim);
> > +               free(data->shim->argv);
> Does this leak data->shim->argv[0] (Ie "shim-%s")?

Yes, I guess it would. I think it's time to look up how to run tests with 
valgrind...

Thanks.
	-Daniel
*This .sig left intentionally blank*
--1547844168-1566878557-1248794757=:2147--
