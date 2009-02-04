From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/1] git-tag: Add --regex option
Date: Wed, 04 Feb 2009 12:23:36 -0800
Message-ID: <7vk586oss7.fsf@gitster.siamese.dyndns.org>
References: <1233677512-1846-1-git-send-email-goulding@vivisimo.com>
 <7vljsm3aow.fsf@gitster.siamese.dyndns.org> <4989A34C.4080104@vivisimo.com>
 <7v4ozaum08.fsf@gitster.siamese.dyndns.org> <4989EE20.1010307@vivisimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jake Goulding <goulding@vivisimo.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:25:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUoJA-0004xS-5y
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbZBDUXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbZBDUXt
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:23:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbZBDUXs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:23:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F0CD996C94;
	Wed,  4 Feb 2009 15:23:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4F5B596C93; Wed,
  4 Feb 2009 15:23:38 -0500 (EST)
In-Reply-To: <4989EE20.1010307@vivisimo.com> (Jake Goulding's message of
 "Wed, 04 Feb 2009 14:36:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B774038C-F2F9-11DD-89D6-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108424>

Jake Goulding <goulding@vivisimo.com> writes:

> Junio C Hamano wrote:
>> Jake Goulding <goulding@vivisimo.com> writes:
>> 
>>> Is that a complete enough description for a rational use-case?
>> 
>> It certainly describes what you are trying to use it for much better than
>> a patch that does not say anything other than "because we can".  A patch
>> marked as RFC could have been written with such an explanation from the
>> beginning to save everybody's time.
>
> My apologies - my previous patch, as you pointed out, was more
> self-evident, and I felt this one was too.

There is no need to apologize.  If a patch without RFC does not have
sufficient justification, I'd just reject it and that would be that, but
an RFC patch is for people to comment on, and it would be a way for you to
get more feedback to give sufficient background material.  It was just a
suggestion to help _you_, not request to help _me_.

>> Currently it cannot, because these useful ref filters are implemented
>> first at the Porcelain level.  Because the plumbing _is_ meant for people
>> writing scripts, that is the issue we should be fixing first.
> ...
> Well, in my defense, it still is a good thing, just not as good as it
> could have been.

Please don't take my "Sad" too seriously.  As I said upfront, it is not
your fault.  I was sad mostly because the existing code was not structured
that way before you started touching it.

> What I am not as clear about is how I can then use that functionality in
> git tag/branch. The main code I messed with in git tag calls
> for_each_tag_ref (and for_each_ref in branch). Would it be appropriate
> to add a struct reference_filter to these functions?

Yeah, if we realize that for_each_*_ref() are all based on for_each_ref()
and about implementing trivial filtering on the result from the latter,
it might be a reasonable approach to do something like this.

	/*
         * generic filter description.  base is typically "refs/heads/"
         * and things like that to cheaply filter the ref.
         *
         * filter_one callback can return 0 to skip, or positive to call
         * the user function supplied to for_each_ref_filtered(), one by
         * one.
         *
         * when filtering many refs at once is more efficient,
         * filter_group can be specified. for_each_ref_filtered() function
         * first collects all the eligible refs into a ref-list, and calls
         * the filter_group callback.  The callback is expected to modify
         * the given ref_list in-place to omit the ones it does not want
         * the user callback to be called. for_each_ref_filtered() will
         * then call the user callback for each of the refs left in the
         * ref_list.
         *
         * when using filter_group, callback data can be placed in
         * cb_data.  when using filter_one callback, the field is used to
         * hold the callback data for the user callback function.
         */
	struct ref_filter {
		char *base;
                each_ref_fn filter_one;
                int (*filter_group)(struct ref_list **, struct ref_filter *);
		void *cb_data;
		each_ref_fn user_fn;
        };

	static int collect_refs(const char *name,
        			const unsigned char *sha1,
                                int flags, void *cb_data)
        {
		struct ref_list **tail = cb_data;
                struct ref_list *entry;
                entry = xmalloc(sizeof(*entry) + strlen(name) + 1);
                strcpy(entry->name, name);
                entry->flag = flag;
                memcpy(entry->sha1, sha1, 20);
                hashclr(entry->peeled);
		*tail = entry;
                entry->next = NULL;
                **tail = &entry->next;
                return 0;
	}

	static int filter_ref(const char *name,
        		      const unsigned char *sha1,
                              int flags, void *cb_data)
        {
		struct ref_filter *filter = cb_data;
		int ret = filter->filter_one(name, sha1, flags, cb_data);
		if (ret <= 0)
                	return ret;
		return filter->user_fn(name, sha1, flags, filter->cb_data);
        }

        int for_each_ref_filtered(each_ref_fn fn,
        			  struct ref_filter *filter,
                                  void *cb_data)
	{
		char *base = filter->base;

		if (!filter->filter_one && !filter->filter_group)
			return for_each_ref(fn, base, cb_data);
                if (filter->filter_group) {
			struct ref_list *collect = NULL;
                        struct ref_list **tail = &collect;
			for_each_ref(collect_refs, base, tail);
			filter->filter_group(&collect_refs, filter->cb_data);
                        while (collect) {
				struct ref_list *entry = collect;
                                retval = do_one_ref(base, fn, 0, entry);
                                if (retval) {
                                	free_ref_list(collect);
                                        return retval;
				}
				collect = entry->next;
                                free(entry);
                        }
                        return 0;
                }
		filter->user_fn = fn;
                return for_each_ref(filter_ref, base, filter);
        }
