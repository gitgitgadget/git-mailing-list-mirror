From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: [PATCH] builtin-branch.c: optimize --merged and --no-merged
Date: Thu, 24 Jul 2008 09:16:22 +0200
Message-ID: <8c5c35580807240016y75b69f69h4af47844f57f4539@mail.gmail.com>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann>
	 <20080723140441.GA9537@elte.hu>
	 <7vy73seb2p.fsf@gitster.siamese.dyndns.org>
	 <7vtzeg9rhh.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Ingo Molnar" <mingo@elte.hu>,
	"=?UTF-8?Q?SZEDER_G=C3=A1bor?=" <szeder@ira.uka.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 09:17:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLv4k-0004kw-VZ
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 09:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbYGXHQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 03:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbYGXHQX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 03:16:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:32109 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbYGXHQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 03:16:22 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2744873rvb.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=a7IzD9UuFnDRezhEaN/4svzg/weQ3o4sJmqdJ2o/TSE=;
        b=OJ8hSEadOAacisTqpxT5W25HBH3yCUiI3667cjyqM8dQUVz4quoqKqm94P4LMRfaKT
         51k1fH8spRxD3SvZoan1YR7iI1nDpcWHHEqqKnHR2rKo7VazfTNWqfccGHt3WAowx3fD
         BKkkaj9Suiva7iGwZBxUf35OtL30TY23jPgno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=wzolBtYq6TM2JjRBbaoSFQrPfr967okBm9i00j9giIRJN53XOAqJroMtkxvv9T3BGH
         qh674AMCBGUmBvDK7M1J60MlVdE+QJSiOedlaHMWbeHjxUgKlGdb3OP58pym7H1Z+BW4
         bAkZY06r2WYMjnK6o6IageUv+Yyuz0e4Zs0kI=
Received: by 10.141.171.6 with SMTP id y6mr305720rvo.85.1216883782247;
        Thu, 24 Jul 2008 00:16:22 -0700 (PDT)
Received: by 10.141.172.11 with HTTP; Thu, 24 Jul 2008 00:16:22 -0700 (PDT)
In-Reply-To: <7vtzeg9rhh.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 41e4bf965c817c39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89843>

On Thu, Jul 24, 2008 at 12:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Instead, we can let the revision machinery traverse the history as if we
> are running:
>
>    $ git rev-list --branches --not $commit
>
> by queueing the tips of branches we encounter as positive refs (this
> mimicks the "--branches" option in the above command line) and then
> appending the merge_filter_ref commit as a negative one, and finally
> calling prepare_revision_walk() to limit the list..

Nice.


> @@ -213,6 +211,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
>  {
>        struct ref_list *ref_list = (struct ref_list*)(cb_data);
>        struct ref_item *newitem;
> +       struct commit *commit;
>        int kind;
>        int len;
>        static struct commit_list branch;

I think you can drop the 'branch' here.


> @@ -239,12 +242,8 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
>                branch.item = lookup_commit_reference_gently(sha1, 1);
>                if (!branch.item)
>                        die("Unable to lookup tip of branch %s", refname);

..and here.


-               if (merge_filter == SHOW_NOT_MERGED &&
-                   has_commit(merge_filter_ref, &branch))
-                       return 0;
-               if (merge_filter == SHOW_MERGED &&
-                   !has_commit(merge_filter_ref, &branch))
-                       return 0;
+               add_pending_object(&ref_list->revs,
+                                  (struct object *)branch.item, refname);


..and use 'commit' instead of 'branch.item' here.


> @@ -305,7 +304,13 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>  {
>        char c;
>        int color;
> -       struct commit *commit;
> +       struct commit *commit = item->commit;
> +
> +       if (merge_filter != NO_FILTER) {
> +               int is_merged = !!(item->commit->object.flags & UNINTERESTING);
> +               if (is_merged != (merge_filter == SHOW_MERGED))
> +                       return;
> +       }


A possible issue here is that `git branch -v --[no]-merged` might use
a wrong maxwidth, but I'm not sure if it's even worth fixing.

Thanks for cleaning up my mess.
--
larsh
