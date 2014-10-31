From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Fri, 31 Oct 2014 00:19:20 -0000
Organization: OPDS
Message-ID: <FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net> <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com> <20141030213523.GA21017@peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 01:19:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjzvu-0005dB-HV
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 01:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161369AbaJaATK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 20:19:10 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:51995 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161331AbaJaATJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2014 20:19:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmUhAAjVUlROl30aPGdsb2JhbABcgw5UWIMGhTvEOhoKh0cBAwEBgSYXAQEBAQEBBQEBAQE4IBuDfQUBAQEBAgEIAQEZBBEWCAEBIQsCAwUCAQMOBwIBAgIFIQICFAEEGAIGBwMMCAYBBwsIAgECAwEMBIgXDQm1S4cAjW4BAQEHAQEBAR6BLI9jDYJxNoEeBYRkgUuLYV6DbIREhAM8iwSFS4Y8gUQ9LwGCSgEBAQ
X-IPAS-Result: AmUhAAjVUlROl30aPGdsb2JhbABcgw5UWIMGhTvEOhoKh0cBAwEBgSYXAQEBAQEBBQEBAQE4IBuDfQUBAQEBAgEIAQEZBBEWCAEBIQsCAwUCAQMOBwIBAgIFIQICFAEEGAIGBwMMCAYBBwsIAgECAwEMBIgXDQm1S4cAjW4BAQEHAQEBAR6BLI9jDYJxNoEeBYRkgUuLYV6DbIREhAM8iwSFS4Y8gUQ9LwGCSgEBAQ
X-IronPort-AV: E=Sophos;i="5.07,290,1413241200"; 
   d="scan'208";a="475249714"
Received: from host-78-151-125-26.as13285.net (HELO PhilipOakley) ([78.151.125.26])
  by out1.ip04ir2.opaltelecom.net with SMTP; 31 Oct 2014 00:19:07 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net>
> On Wed, Oct 29, 2014 at 12:16:05PM -0700, Junio C Hamano wrote:
>
>> Probably three helper functions:
>>
>>  - The first is to find tops and bottoms (this translates fuzzy
>>    specifications such as "--since 30.days" into a more concrete
>>    revision range "^A ^B ... Z" to establish bundle prerequisites),
>>    which is done by running a "rev-list --boundary".
>>
>>  - The second is to show refs, while paying attention to things like
>>    "--10 maint master" which may result in the tip of 'maint' not
>>    being shown at all.  I am not sure if this part can/should take
>>    advantage of revs.cmdline, though.
>>
>>  - The last is to create the actual pack data.
>>
>> I agree with your analysis on the change in column.c and trailer.c
>
> I was not planning to work on this, but since you did the first and
> third bullet points, I think it makes sense to start the second one 
> with
> this cleanup:
>
> -- >8 --
> Subject: bundle: split out ref writing from bundle_create
>
> The bundle_create() function has a number of logical steps:
> process the input, write the refs, and write the packfile.
> Recent commits split the first and third into separate
> sub-functions. It's worth splitting the middle step out,
> too, if only because it makes the progression of the steps
> more obvious.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Obviously this should be dropped if somebody is actively working on 
> the
> revs.cmdline thing you mentioned, as it would conflict horribly. But I
> think it is a nice step for somebody working on it later, because the
> revs.cmdline changes should be isolated to write_bundle_refs.

As a side project (slow time) I've been looking at the loss of the HEAD 
symbolic ref when multiple heads are bundled that point at the same rev. 
That is, when the HEAD detection heuristic fails.

What I've noticed so far is that a duplicated ref (added to the bundle 
manually) simply creates a warning (currently, and the warning names 
that ref) rather than failing when cloned (and by implication fetched). 
Not only that the bundle verify command does not report any error for 
such a bundle containing a duplicate ref.

Given that, if the refs were sorted, and HEAD was listed last (as is the 
case with '--all'), then one could add the duplicate ref immediately 
after HEAD, of it's symbolic ref. I.e if a duplicate ref is found after 
HEAD then that ref is the true HEAD ref. This duplicate ref would only 
need to be present if there are multiple (two or more) heads that point 
to the same rev, and the HEAD isn't detatched. Sorting is necessary to 
ensure that HEAD is last and its duplicate refs/head ref immediately 
follows.

Thus the first step is to ensure that the positive refs list is sorted 
such that HEAD (and it's ilk) is last.

I'd also planned an option '--HEAD' which would add such a duplicate ref 
to a V2 bundle (resulting in a warning for older users which displays 
the duplicate head ref!)

An option '--V3' would be the same as '--HEAD' but would also change the 
bundle string version number (to V3), and so would not be acceptable to 
older systems (for those that require such separation) but the 
clone/fetch on a newer system would detect the V3 in the header string 
and then use the extra ref rather than the heuristic to determine HEAD 
(with appropriate checks).

I hadn't finished my studies of the refs.c code to fully understand what 
I'd need to change, but hopefully the changes in this patch can be 
aligned in the same direction (or the errors in my reasoning be pointed 
out;-)

The need to sort the refs in this method would separate the 
determination of the correct refs from the writing of the refs. All 
assuming the idea has merit...

--
Philip

>
> bundle.c | 97 
> ++++++++++++++++++++++++++++++++++++++--------------------------
> 1 file changed, 58 insertions(+), 39 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 0ca8737..ca4803b 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -310,43 +310,22 @@ static int compute_and_write_prerequistes(int 
> bundle_fd,
>  return 0;
> }
>
> -int create_bundle(struct bundle_header *header, const char *path,
> -   int argc, const char **argv)
> +/*
> + * Write out bundle refs based on the tips already
> + * parsed into revs.pending. As a side effect, may
> + * manipulate revs.pending to include additional
> + * necessary objects (like tags).
> + *
> + * Returns the number of refs written, or negative
> + * on error.
> + */
> +static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
> {
> - static struct lock_file lock;
> - int bundle_fd = -1;
> - int bundle_to_stdout;
> - int i, ref_count = 0;
> - struct rev_info revs;
> -
> - bundle_to_stdout = !strcmp(path, "-");
> - if (bundle_to_stdout)
> - bundle_fd = 1;
> - else
> - bundle_fd = hold_lock_file_for_update(&lock, path,
> -       LOCK_DIE_ON_ERROR);
> -
> - /* write signature */
> - write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
> -
> - /* init revs to list objects for pack-objects later */
> - save_commit_buffer = 0;
> - init_revisions(&revs, NULL);
> -
> - /* write prerequisites */
> - if (compute_and_write_prerequistes(bundle_fd, &revs, argc, argv))
> - return -1;
> -
> - /* write references */
> - argc = setup_revisions(argc, argv, &revs, NULL);
> -
> - if (argc > 1)
> - return error(_("unrecognized argument: %s"), argv[1]);
> -
> - object_array_remove_duplicates(&revs.pending);
> + int i;
> + int ref_count = 0;
>
> - for (i = 0; i < revs.pending.nr; i++) {
> - struct object_array_entry *e = revs.pending.objects + i;
> + for (i = 0; i < revs->pending.nr; i++) {
> + struct object_array_entry *e = revs->pending.objects + i;
>  unsigned char sha1[20];
>  char *ref;
>  const char *display_ref;
> @@ -361,7 +340,7 @@ int create_bundle(struct bundle_header *header, 
> const char *path,
>  display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
>
>  if (e->item->type == OBJ_TAG &&
> - !is_tag_in_date_range(e->item, &revs)) {
> + !is_tag_in_date_range(e->item, revs)) {
>  e->item->flags |= UNINTERESTING;
>  continue;
>  }
> @@ -407,7 +386,7 @@ int create_bundle(struct bundle_header *header, 
> const char *path,
>  */
>  obj = parse_object_or_die(sha1, e->name);
>  obj->flags |= SHOWN;
> - add_pending_object(&revs, obj, e->name);
> + add_pending_object(revs, obj, e->name);
>  }
>  free(ref);
>  continue;
> @@ -420,11 +399,51 @@ int create_bundle(struct bundle_header *header, 
> const char *path,
>  write_or_die(bundle_fd, "\n", 1);
>  free(ref);
>  }
> - if (!ref_count)
> - die(_("Refusing to create empty bundle."));
>
>  /* end header */
>  write_or_die(bundle_fd, "\n", 1);
> + return ref_count;
> +}
> +
> +int create_bundle(struct bundle_header *header, const char *path,
> +   int argc, const char **argv)
> +{
> + static struct lock_file lock;
> + int bundle_fd = -1;
> + int bundle_to_stdout;
> + int ref_count = 0;
> + struct rev_info revs;
> +
> + bundle_to_stdout = !strcmp(path, "-");
> + if (bundle_to_stdout)
> + bundle_fd = 1;
> + else
> + bundle_fd = hold_lock_file_for_update(&lock, path,
> +       LOCK_DIE_ON_ERROR);
> +
> + /* write signature */
> + write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
> +
> + /* init revs to list objects for pack-objects later */
> + save_commit_buffer = 0;
> + init_revisions(&revs, NULL);
> +
> + /* write prerequisites */
> + if (compute_and_write_prerequistes(bundle_fd, &revs, argc, argv))
> + return -1;
> +
> + argc = setup_revisions(argc, argv, &revs, NULL);
> +
> + if (argc > 1)
> + return error(_("unrecognized argument: %s"), argv[1]);
> +
> + object_array_remove_duplicates(&revs.pending);
> +
> + ref_count = write_bundle_refs(bundle_fd, &revs);
> + if (!ref_count)
> + die(_("Refusing to create empty bundle."));
> + else if (ref_count < 0)
> + return -1;
>
>  /* write pack */
>  if (write_pack_data(bundle_fd, &lock, &revs))
> -- 
> 2.1.2.596.g7379948
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
