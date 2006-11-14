X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/5] allow deepening of a shallow repository
Date: Tue, 14 Nov 2006 12:03:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611141150010.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610302009390.26682@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7qeze0q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 14 Nov 2006 11:03:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vy7qeze0q.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31344>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjw4x-0000XV-ON for gcvg-git@gmane.org; Tue, 14 Nov
 2006 12:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933412AbWKNLDo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 06:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933413AbWKNLDn
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 06:03:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:6597 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S933412AbWKNLDn (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 06:03:43 -0500
Received: (qmail invoked by alias); 14 Nov 2006 11:03:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp037) with SMTP; 14 Nov 2006 12:03:41 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 13 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now, by saying "git fetch -depth <n> <repo>" you can deepen
> > a shallow repository.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  commit.c      |   13 +++++++++++++
> >  commit.h      |    3 ++-
> >  fetch-pack.c  |   22 ++++++++++++++++------
> >  git-fetch.sh  |   12 +++++++++++-
> >  shallow.c     |    8 ++++++--
> >  upload-pack.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++-----------
> > diff --git a/upload-pack.c b/upload-pack.c
> > index ebe1e5a..162dd34 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -134,6 +134,7 @@ static void create_pack_file(void)
> >  		} else {
> >  			for (i = 0; i < want_obj.nr; i++) {
> >  				struct object *o = want_obj.objects[i].item;
> > +				o->flags &= ~UNINTERESTING;
> >  				add_pending_object(&revs, o, NULL);
> >  			}
> >  			for (i = 0; i < have_obj.nr; i++) {
> 
> I am puzzled why this is needed in this series.  In other words,
> do we have a bug in the current upload-pack that does not have
> shallow already by not clearing UNINTERESTING bit?  In yet other
> words, I haven't figured out which part of the shallow series
> makes it necessary to clear UNINTERESTING bit from wanted
> object.

IIRC (has been a long time, hasn't it?) the test failed without that line, 
and I was too lazy to investigate why. But ICRI ;-)

> > @@ -547,23 +554,51 @@ static void receive_needs(void)
> >...
> > +		for (i = 0; i < shallows.nr; i++) {
> > +			struct object *object = shallows.objects[i].item;
> > +			if (object->flags & NOT_SHALLOW) {
> > +				struct commit_list *parents;
> > +				packet_write(1, "unshallow %s",
> > +					sha1_to_hex(object->sha1));
> > +				object->flags &= ~CLIENT_SHALLOW;
> > +				/* make sure the real parents are parsed */
> > +				unregister_shallow(object->sha1);
> > +				parse_commit((struct commit *)object);
> > +				parents = ((struct commit *)object)->parents;
> > +				while (parents) {
> > +					add_object_array(&parents->item->object,
> > +							NULL, &want_obj);
> > +					parents = parents->next;
> > +				}
> > +			}
> 
> I doubt unregister_shallow() is enough to ensure that the next
> parse_commit() re-parses to recover its parents.  parse_commit()
> says "if (item->object.parsed) return 0" upfront.  Don't you
> need to do:
> 
> 	object->parsed = 0;
> 
> before parse_commit()?

Yes. Somehow, an important part of unregister_shallow() went missing (yet 
another proof that my poor-man's-StGit does not always work). I think that 
the "object->parsed = 0;" should go into unregister_shallow() like this:

diff --git a/commit.c b/commit.c
index d5103cd..4451376 100644
--- a/commit.c
+++ b/commit.c
@@ -258,6 +258,7 @@ int write_shallow_commits(int fd, int us
 int unregister_shallow(const unsigned char *sha1)
 {
 	int pos = commit_graft_pos(sha1);
+	struct commit *commit = lookup_commit(sha1);
 	if (pos < 0)
 		return -1;
 	if (pos + 1 < commit_graft_nr)
@@ -265,6 +266,8 @@ int unregister_shallow(const unsigned ch
 				sizeof(struct commit_graft *)
 				* (commit_graft_nr - pos - 1));
 	commit_graft_nr--;
+	if (commit)
+		commit->object.parsed = 0;
 	return 0;
 }
 
Ciao,
Dscho
