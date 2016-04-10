From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/4] builtin/interpret-trailers: suppress blank line
Date: Sun, 10 Apr 2016 17:56:00 +0300
Message-ID: <20160410175217-mutt-send-email-mst@redhat.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
 <1460042563-32741-3-git-send-email-mst@redhat.com>
 <xmqqmvp51hhm.fsf@gitster.mtv.corp.google.com>
 <20160407201853-mutt-send-email-mst@redhat.com>
 <xmqq1t6h1fwk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 16:56:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apGmZ-0003at-PI
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 16:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbcDJO4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 10:56:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbcDJO4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 10:56:05 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8E8046267;
	Sun, 10 Apr 2016 14:56:03 +0000 (UTC)
Received: from redhat.com (vpn1-5-25.ams2.redhat.com [10.36.5.25])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3AEu0l4001171;
	Sun, 10 Apr 2016 10:56:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1t6h1fwk.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291175>

On Thu, Apr 07, 2016 at 10:34:51AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > No - but then I will need to re-run mailinfo to parse the result,
> > will I not?
> 
> By the way, I suspect (if Christian did his implementation right
> when he did interpret-trailers) all these points may become moot.
> 
> I haven't re-reviewed what is in interpret-trailers, but the vision
> has been that its internal workings should be callable directly into
> instead of running it via run_commands() interface passing the data
> via on-disk file.  In the codepath you touch in 3/4 and 4/4, you
> already have not just mi.log_message but msg that has the whole
> payload to create a commit object out of already, so shouldn't it be
> just the matter of passing <msg.buf, msg.len> to some API function
> that was prepared to implement interpret-trailers?

That's certainly possible, though it will need a rework
of the internal API: we currently have:

void process_trailers(const char *file, int in_place, int trim_empty,
                      int suppress_blank_line, struct string_list *trailers)
{
        struct trailer_item *in_tok_first = NULL;
        struct trailer_item *in_tok_last = NULL;
        struct trailer_item *arg_tok_first;
        struct strbuf **lines;
        int trailer_end;
        FILE *outfile = stdout;

        /* Default config must be setup first */
        git_config(git_trailer_default_config, NULL);
        git_config(git_trailer_config, NULL);

        lines = read_input_file(file);

So process_trailers can be changed to get struct strbuf ** instead.

But it seems that the output would have to go into a temporary file
anyway, unless trailer.c is completely rewritten, since it
currently does all output by writing it into a file.
Is that an issue?

-- 
MST
