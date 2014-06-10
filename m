From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 15/15] commit: record buffer length in cache
Date: Tue, 10 Jun 2014 23:30:37 +0200 (CEST)
Message-ID: <20140610.233037.83802811806074490.chriscool@tuxfamily.org>
References: <20140610.071237.852310668484562387.chriscool@tuxfamily.org>
	<20140610052713.GA2978@sigill.intra.peff.net>
	<20140610203349.GG14974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	sunshine@sunshineco.com
To: peff@peff.net
X-From: git-owner@vger.kernel.org Tue Jun 10 23:31:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTdK-0005f5-I0
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbaFJVbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:31:02 -0400
Received: from [194.158.98.45] ([194.158.98.45]:34537 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752924AbaFJVbB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:31:01 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 9BF2B47;
	Tue, 10 Jun 2014 23:30:38 +0200 (CEST)
In-Reply-To: <20140610203349.GG14974@sigill.intra.peff.net>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251240>

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/15] commit: record buffer length in cache
Date: Tue, 10 Jun 2014 16:33:49 -0400

> On Tue, Jun 10, 2014 at 01:27:13AM -0400, Jeff King wrote:
> 
>> > I find the above strange. I would have done something like:
>> > 
>> > -	set_commit_buffer(commit, strbuf_detach(&msg, NULL));
>> > +	size_t size;
>> > +	char *buf = strbuf_detach(&msg, &size);
>> > +	set_commit_buffer(commit, buf, size);
>> 
>> It is a little strange. You can't do:
>> 
>>   set_commit_buffer(commit, strbuf_detach(&msg, NULL), msg.len);
>> 
>> because the second argument resets msg.len as a side effect. Doing it
>> your way is longer, but perhaps is a bit more canonical. In general, one
>> should call strbuf_detach to ensure that the buffer is allocated (and
>> does not point to slopbuf). That's guaranteed here, because we just put
>> contents into the buffer, but it's probably more hygienic to use the
>> more verbose form.
> 
> I was trying to avoid cluttering up the function with the extra variable
> definitions. I ended up with the change below, which I think is clear,
> correct, and pushes the complexity outside of the function.

Yeah, great!
 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index cde19eb..53f43ab 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2266,6 +2266,18 @@ static void append_merge_parents(struct commit_list **tail)
>  }
>  
>  /*
> + * This isn't as simple as passing sb->buf and sb->len, because we
> + * want to transfer ownership of the buffer to the commit (so we
> + * must use detach).
> + */
> +static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
> +{
> +	size_t len;
> +	void *buf = strbuf_detach(sb, &len);
> +	set_commit_buffer(c, buf, len);
> +}
> +
> +/*
>   * Prepare a dummy commit that represents the work tree (or staged) item.
>   * Note that annotating work tree item never works in the reverse.
>   */
> @@ -2313,7 +2325,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  		    ident, ident, path,
>  		    (!contents_from ? path :
>  		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
> -	set_commit_buffer(commit, strbuf_detach(&msg, NULL));
> +	set_commit_buffer_from_strbuf(commit, &msg);
>  
>  	if (!contents_from || strcmp("-", contents_from)) {
>  		struct stat st;

Thanks,
Christian. 
