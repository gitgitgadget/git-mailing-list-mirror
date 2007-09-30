From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] fetch/push: readd rsync support
Date: Sun, 30 Sep 2007 13:58:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709301344560.28395@racer.site>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
 <Pine.LNX.4.64.0709281629270.28395@racer.site> <7vtzpeo5ar.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709290134000.28395@racer.site> <7vhclciszz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 14:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbyOk-0003oL-Mu
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 14:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbXI3M7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 08:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbXI3M7m
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 08:59:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:53121 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753801AbXI3M7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 08:59:42 -0400
Received: (qmail invoked by alias); 30 Sep 2007 12:59:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 30 Sep 2007 14:59:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gOtIEy71glj194gFIvreOnH/xbEKcrKMMyMd9S9
	r9x0kYUsMkhMVm
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhclciszz.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59538>

Hi,

On Sat, 29 Sep 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > We lost rsync support when transitioning from shell to C.  Support it
> > again (even if the transport is technically deprecated, some people just
> > do not have any chance to use anything else).
> 
> s/chance/choice/?

Hehe. I did mean it like that, but feel free to edit!

> > +test "$TEST_RSYNC" && {
> 
> Somehow this feels dirty ... perhaps leave early like:
> 
> 	if test -z "$TEST_RSYNC"
>         then
>         	test_expect_success 'skipping rsync transport tests' :
> 		test_done
>                 exit
> 	fi

Okay.

> > diff --git a/transport.c b/transport.c
> > index 4f9cddc..a2ee8f3 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -6,6 +6,330 @@
> > ...
> > +{
> > +	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
> > +	struct ref dummy, *tail = &dummy;
> > +	struct child_process rsync;
> > +	const char *args[5];
> > +	int temp_dir_len;
> > +
> > +	/* copy the refs to the temporary directory */
> > +
> > +	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
> > +	if (!mkdtemp(temp_dir.buf))
> > +		die ("Could not make temporary directory");
> 
> I wonder how portable mkdtemp() is (it does not seem to be POSIX);
> would we need something in compat/ perhaps based on tempnam()?

My man page said BSD, so I did not bother any more...

Besides, using "tmpnam()" makes gcc say that it is dangerous, and I should 
use mkstemp() instead...

> > +static int fetch_objs_via_rsync(struct transport *transport,
> > +				 int nr_objs, struct ref **to_fetch)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct child_process rsync;
> > +	const char *args[8];
> > +	int result;
> > +
> > +	strbuf_addstr(&buf, transport->url);
> > +	strbuf_addstr(&buf, "/objects/");
> > +
> > +	memset(&rsync, 0, sizeof(rsync));
> > +	rsync.argv = args;
> > +	rsync.stdout_to_stderr = 1;
> > +	args[0] = "rsync";
> > +	args[1] = transport->verbose ? "-rv" : "-r";
> > +	args[2] = "--ignore-existing";
> > +	args[3] = "--exclude";
> > +	args[4] = "info";
> > +	args[5] = buf.buf;
> > +	args[6] = get_object_directory();
> > +	args[7] = NULL;
> 
> Hmm, we used to do "rsync $remote/objects/ $our/.git/objects/", but this 
> omits the trailing "/" from our side.  I suspect the reason was to deal 
> with the case where our .git/objects was a symlink to elsewhere (which 
> was how you did alternates before alternates was invented), which may 
> not matter anymore these days.

Nevertheless, this was an oversight on my side. Will change to use a 
second strbuf for the local objects directory.
