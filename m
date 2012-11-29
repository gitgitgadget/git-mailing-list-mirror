From: Max Horn <postbox@quendi.de>
Subject: Re: [PATCH v7 p2 1/2] fast-export: don't handle uninteresting refs
Date: Thu, 29 Nov 2012 02:16:28 +0100
Message-ID: <8FA492C2-71B0-44AB-B816-AFB6C91DC01C@quendi.de>
References: <1354141440-26534-1-git-send-email-felipe.contreras@gmail.com> <1354141440-26534-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 02:17:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdskN-00081U-Ki
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 02:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509Ab2K2BQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 20:16:44 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:38693 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756619Ab2K2BQn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 20:16:43 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=[192.168.178.27]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Tdsjt-0001tt-HE; Thu, 29 Nov 2012 02:16:29 +0100
In-Reply-To: <1354141440-26534-2-git-send-email-felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;postbox@quendi.de;1354151802;e02b7f36;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210804>


On 28.11.2012, at 23:23, Felipe Contreras wrote:

> They have been marked as UNINTERESTING for a reason, lets respect that.
> 
> Currently the first ref is handled properly, but not the rest:
> 
>  % git fast-export master ^uninteresting ^foo ^bar

All these refs are assumed to point to the same object, right? I think it would be better if the commit message stated that explicitly. To make up for the lost space, you could then get rid of one of the four refs, I think three are sufficient to drive the message home ;-).


<snip>

> The reason this happens is that before traversing the commits,
> fast-export checks if any of the refs point to the same object, and any
> duplicated ref gets added to a list in order to issue 'reset' commands
> after the traversing. Unfortunately, it's not even checking if the
> commit is flagged as UNINTERESTING. The fix of course, is to do
> precisely that.

Hm... So this might be me being a stupid n00b (I am not yet that familiar with the internal rep of things in git and all...)... but I found the "precisely that" par very confusing, because right afterwards, you say:

> 
> However, in order to do it properly we need to get the UNINTERESTING flag
> from the command line ref, not from the commit object.

So this sounds like you are saying "we do *precisely* that, except we don't, because it is more complicated, so we actually don't do this *precisely*, just manner of speaking..."

Some details here are beyond my knowledge, I am afraid, so I have to resort to guess: In particular it is not clear to me why the "however" part pops up: Reading it makes it sound as if the commit object also carries an UNINTERESTING flag, but we can't use it because of some reason (perhaps it doesn't have the semantics we need?), so we have to look at revs.pending instead. Right? Wrong? Or is it because the commit objects actually do *not* carry the UNINTERESTING bits, hence we need to look at revs.pending. Or is it due to yet another reason?

I would find it helpful if that could be clarified. E.g. like so:

 "The fix is to add such a check. However, we cannot just use the UNINTERESTING flag of the commit object, because INSERT-REASON."

or

 "The fix is to add such a check. However, the commit object does not contain the UNINTERESTING flag directly."

or something.

Anyway, other than these nitpicky questions, this whole thing looks very logical to me, description and code alike. I also played around with tons of "fast-export" invocations, with and without this patch, and it seems to do what the description says. Finally, I went to the various long threads discussion prior versions of this patch, in particular those starting at
  http://thread.gmane.org/gmane.comp.version-control.git/208725
and
  http://thread.gmane.org/gmane.comp.version-control.git/209355/focus=209370

These contained some concerns. Sadly, several of those discussions ultimately degenerated into not-so-pleasant exchanges :-(, and my impression is that as a result some people are not so inclined to comment on these patches anymore at all. Which is a pity :-(. But overall, it seems this patch makes nothing worse, but fixes some things; and it is simple enough that it shouldn't make future improvements harder.

So *I* at least am quite happy with this, it helps me! My impression is that Felipe's latest patch addresses most concerns people raised by means of an improved description. I couldn't find any in those threads that I feel still applies -- but of course those people should speak for themselves, I am simply afraid they don't want to be part of this anymore :-(.


Still, for what little it might be worth, I think this patch is good and a real improvement. I hope it can be merged soon.


Cheers,
Max


> Fortunately we
> can simply use revs.pending, which contains all the information we need
> for get_tags_and_duplicates(), plus the ref flag. This way the rest of
> the positive refs will remain untouched; it's only the negative ones
> that change in behavior.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> builtin/fast-export.c     | 11 +++++++----
> t/t5801-remote-helpers.sh |  8 ++++++++
> t/t9350-fast-export.sh    | 30 ++++++++++++++++++++++++++++++
> 3 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 191936c..2547e6c 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -474,18 +474,21 @@ static void handle_tag(const char *name, struct tag *tag)
> 	       (int)message_size, (int)message_size, message ? message : "");
> }
> 
> -static void get_tags_and_duplicates(struct object_array *pending,
> +static void get_tags_and_duplicates(struct rev_cmdline_info *info,
> 				    struct string_list *extra_refs)
> {
> 	struct tag *tag;
> 	int i;
> 
> -	for (i = 0; i < pending->nr; i++) {
> -		struct object_array_entry *e = pending->objects + i;
> +	for (i = 0; i < info->nr; i++) {
> +		struct rev_cmdline_entry *e = info->rev + i;
> 		unsigned char sha1[20];
> 		struct commit *commit;
> 		char *full_name;
> 
> +		if (e->flags & UNINTERESTING)
> +			continue;
> +
> 		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
> 			continue;
> 
> @@ -681,7 +684,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
> 	if (import_filename && revs.prune_data.nr)
> 		full_tree = 1;
> 
> -	get_tags_and_duplicates(&revs.pending, &extra_refs);
> +	get_tags_and_duplicates(&revs.cmdline, &extra_refs);
> 
> 	if (prepare_revision_walk(&revs))
> 		die("revision walk setup failed");
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index 12ae256..ece8fd5 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -162,4 +162,12 @@ test_expect_failure 'pushing without marks' '
> 	compare_refs local2 HEAD server HEAD
> '
> 
> +test_expect_success 'push all with existing object' '
> +	(cd local &&
> +	git branch dup2 master &&
> +	git push origin --all
> +	) &&
> +	compare_refs local dup2 server dup2
> +'
> +
> test_done
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 1f59862..c8e41c1 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -454,4 +454,34 @@ test_expect_success 'test bidirectionality' '
> 	git fast-import --export-marks=marks-cur --import-marks=marks-cur
> '
> 
> +cat > expected << EOF
> +blob
> +mark :13
> +data 5
> +bump
> +
> +commit refs/heads/master
> +mark :14
> +author A U Thor <author@example.com> 1112912773 -0700
> +committer C O Mitter <committer@example.com> 1112912773 -0700
> +data 5
> +bump
> +from :12
> +M 100644 :13 file
> +
> +EOF
> +
> +test_expect_success 'avoid uninteresting refs' '
> +	> tmp-marks &&
> +	git fast-export --import-marks=tmp-marks \
> +		--export-marks=tmp-marks master > /dev/null &&
> +	git tag v1.0 &&
> +	git branch uninteresting &&
> +	echo bump > file &&
> +	git commit -a -m bump &&
> +	git fast-export --import-marks=tmp-marks \
> +		--export-marks=tmp-marks ^uninteresting ^v1.0 master > actual &&
> +	test_cmp expected actual
> +'
> +
> test_done
> -- 
> 1.8.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
