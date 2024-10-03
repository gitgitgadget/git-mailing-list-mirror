Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD217579
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727935902; cv=none; b=tNbULYjXYaqfBX83esVtF9OQIc/roWv1jDV0L6XQ0gZ2VmIFCqpoGX3mR/QKMOKjzs2owMgEJKPERbKrS59KQ8VRrs4uT1KlMbML4LUX8ZnrjvKmbUO12hWVqrJkmTV2PLY+LzMlOmODY7PaG/yDERoQ4YT5oLmJoBdksPhWW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727935902; c=relaxed/simple;
	bh=6tGDOwLeqLC/F1b0s6wG3EoTG0X+jdwmIrMCdPP1sKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0BJBklaqZ9GXOrjDU+OS0ee1IWVyRVvM4fy5ix5vPuAVmiOMxKONV4dVOLpWwXpTZYvnKt0/fr1eDyo6jjqItrrkDTuxnoag4ObaRBELZaZr6J93zBDedy0ATlyrStQ5jI+VxJXJYHDbz4mzlPYlAebqvc4Pk0OUM00WzVR+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hV1J5XcH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hV1J5XcH"
Received: (qmail 12128 invoked by uid 109); 3 Oct 2024 06:11:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6tGDOwLeqLC/F1b0s6wG3EoTG0X+jdwmIrMCdPP1sKQ=; b=hV1J5XcHI7pL1gAEWnWTcns6hF/s7R+s2a5XFFcAR1U5a0cSv4CmLutx6gXFtH15oyBHbY7WDNCx8I7nHr3lOwIU3/yCei/jWdWfLwjPajHQZKFpt7Q5YL2OC4kjaX5Nl1ycOu5Dtf5GXdUKkHejdv8RKTgj1CSInjeEff+LB03PWYM8rtnJlGNszJsuf/fMShAf80RwqsMS8XODULbWV4JNIzS9DaiL4sD6B2o02ROBAnhQXD+9b668KMZSOME+fUAvODO5PkDOgxyxLmcBWf1oC7g0Je07JL4aqZGV5VY48oXXJdqpe2uzbtkygPUfDPAH2kcgOg1TDLAdoLeK4g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 06:11:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14155 invoked by uid 111); 3 Oct 2024 06:11:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Oct 2024 02:11:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Oct 2024 02:11:36 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH] line-log: protect inner strbuf from free
Message-ID: <20241003061136.GA351404@coredump.intra.peff.net>
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
 <20241002235639.GB3455554@coredump.intra.peff.net>
 <1fc0d162-9814-4d94-ac67-2ea8e40495f4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fc0d162-9814-4d94-ac67-2ea8e40495f4@gmail.com>

On Wed, Oct 02, 2024 at 10:36:33PM -0400, Derrick Stolee wrote:

> >       It does make me wonder what leak Patrick saw that caused him to
> >       write 394affd46d, and whether we're now leaking in some case that
> >       I'm missing.
> 
> Looking at the change, I can only guess that it was the previous use of
> 
> 	char *prefix = "";
> 
> that signaled that an unfreeable string was being assigned to a non-const
> pointer. This signals that _something_ is wrong with the function, but
> the way that the buffer is returned by the function pointer is suspicious,
> too.

Ah, of course. I saw Patrick's name and just assumed it was part of
leak-checking fixes. But of course he also fixed -Wwrite-strings issues.

> > I do think this would have been a harder mistake to make if the callback
> > simply returned a "const char *" pointer. We'd lose the ability to show
> > prefixes with embedded NULs, but I'm not sure that's a big deal. It
> > would also help for line-log to use the existing helper rather than
> > inventing its own. So together on top something like this (which I'd
> > probably turn into two patches if this seems to others like it's
> > valuable and not just churn):
> 
> I do agree that changing the return type will make this easier to prevent
> and the code should be easier to read as well.
> 
> Your diffed patch looks pretty good. I made an attempt at guessing where
> you would have split them (first remove the duplicate method, then change
> the method prototype and callers).

Yep, exactly. I actually ended up with a third patch which is a nearby
cleanup. I'll hold them back for now, though. Your patch is a regression
fix which we should prioritize (though it sounds like it is in 2.46, not
the upcoming 2.47?). I'll post my on top as a separate series.

> I even took some time to attempt to remove the static strbuf from
> diff_output_prefix_callback() in favor of using the 'data' member of the
> diff_options struct, but it was not incredibly obvious how to communicate
> ownership of the struct which would need to store both the graph struct
> and the strbuf. Perhaps this would be good for #leftoverbits.

Yeah, I think probably "struct git_graph" would need to own the buffer,
initialize it in graph_init(), and then discard it in graph_clear().
But that gets weird because apparently you can set the callback without
a git_graph? Looks like that is triggered by "--line-prefix" without
"--graph". Yuck.

But in that case we are just showing the line_prefix string, so we could
return that directly. Something like the patch below.

The whole thing feels a bit over-engineered with the callback. The graph
code is the only one that needs anything beyond a static string. And the
way --line-prefix interacts with it is odd, since some callers override
the callback (e.g., "range-diff --line-prefix=foo" is accepted, but
doesn't do anything). I don't think there's a bug anybody cares about,
but, well...it's not how I would have written it. ;)

diff --git a/graph.c b/graph.c
index c046f6285d..bf000fdbe1 100644
--- a/graph.c
+++ b/graph.c
@@ -309,21 +309,28 @@ struct git_graph {
 	 * stored as an index into the array column_colors.
 	 */
 	unsigned short default_column_color;
+
+	/*
+	 * Scratch buffer for generating prefixes to be used with
+	 * diff_output_prefix_callback().
+	 */
+	struct strbuf prefix_buf;
 };
 
 static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
-	static struct strbuf msgbuf = STRBUF_INIT;
 
 	assert(opt);
 
-	strbuf_reset(&msgbuf);
+	if (!graph)
+		return opt->line_prefix;
+
+	strbuf_reset(&graph->prefix_buf);
 	if (opt->line_prefix)
-		strbuf_addstr(&msgbuf, opt->line_prefix);
-	if (graph)
-		graph_padding_line(graph, &msgbuf);
-	return msgbuf.buf;
+		strbuf_addstr(&graph->prefix_buf, opt->line_prefix);
+	graph_padding_line(graph, &graph->prefix_buf);
+	return graph->prefix_buf.buf;
 }
 
 static const struct diff_options *default_diffopt;
@@ -393,6 +400,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 * The diff output prefix callback, with this we can make
 	 * all the diff output to align with the graph lines.
 	 */
+	strbuf_init(&graph->prefix_buf, 0);
 	opt->diffopt.output_prefix = diff_output_prefix_callback;
 	opt->diffopt.output_prefix_data = graph;
 
@@ -408,6 +416,7 @@ void graph_clear(struct git_graph *graph)
 	free(graph->new_columns);
 	free(graph->mapping);
 	free(graph->old_mapping);
+	strbuf_release(&graph->prefix_buf);
 	free(graph);
 }
 

-Peff
