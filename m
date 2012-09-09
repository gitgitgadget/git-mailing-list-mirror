From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Add a new function, filter_string_list()
Date: Sun, 09 Sep 2012 02:40:30 -0700
Message-ID: <7vk3w3sfe9.fsf@alter.siamese.dyndns.org>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
 <1347169990-9279-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 09 11:40:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAe0P-0007rC-Dp
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 11:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab2IIJke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 05:40:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab2IIJkd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 05:40:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2068476D5;
	Sun,  9 Sep 2012 05:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Scw9AKokyApn9GJegpDyISa8J+E=; b=OfxVV3
	5KsxVKWEakhPWMqBHw/LQZ2ZkktK1nfhnV+HFANIG8p8CWUEbWEbIg4NOBNyc5Vi
	HXeiyCCt87SW5Yy5yUcMaSTskaWqBBlAgqXvIcywvMBg+dhcNU4sIH8hqlMbN5/x
	Ebd02eCC62pz+UBhcqxnxmK36SOr5UEoNIKaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A7+gnK4LfzJYoLPF/bJKCQn2QGXHQmI1
	OV+ofwxizRQS3ZhiBbaKo25HDbERxNwSMH3AEMbJ/NIkakj0DO0yqCyztd9c6O6v
	NLHQg7FozOC1tn5fgzmwzQG68/gVeyI+TLtSkutXuaLqaSgsh/EOjx6fdf8hXSvP
	ls/L66vN4BU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E2A676D3;
	Sun,  9 Sep 2012 05:40:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CEDB76D2; Sun,  9 Sep 2012
 05:40:32 -0400 (EDT)
In-Reply-To: <1347169990-9279-3-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Sun, 9 Sep 2012 07:53:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6605E816-FA62-11E1-8086-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205071>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/technical/api-string-list.txt |  8 ++++++++
>  string-list.c                               | 17 +++++++++++++++++
>  string-list.h                               |  9 +++++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
> index 3b959a2..15b8072 100644
> --- a/Documentation/technical/api-string-list.txt
> +++ b/Documentation/technical/api-string-list.txt
> @@ -60,6 +60,14 @@ Functions
>  
>  * General ones (works with sorted and unsorted lists as well)
>  
> +`filter_string_list`::
> +
> +	Apply a function to each item in a list, retaining only the
> +	items for which the function returns true.  If free_util is
> +	true, call free() on the util members of any items that have
> +	to be deleted.  Preserve the order of the items that are
> +	retained.

In other words, this can safely be used on both sorted and unsorted
string list.  Good.

>  `print_string_list`::
>  
>  	Dump a string_list to stdout, useful mainly for debugging purposes. It
> diff --git a/string-list.c b/string-list.c
> index 110449c..72610ce 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -102,6 +102,23 @@ int for_each_string_list(struct string_list *list,
>  	return ret;
>  }
>  
> +void filter_string_list(struct string_list *list, int free_util,
> +			string_list_each_func_t fn, void *cb_data)
> +{
> +	int src, dst = 0;
> +	for (src = 0; src < list->nr; src++) {
> +		if (fn(&list->items[src], cb_data)) {
> +			list->items[dst++] = list->items[src];
> +		} else {
> +			if (list->strdup_strings)
> +				free(list->items[src].string);
> +			if (free_util)
> +				free(list->items[src].util);
> +		}
> +	}
> +	list->nr = dst;
> +}
> +
>  void string_list_clear(struct string_list *list, int free_util)
>  {
>  	if (list->items) {
> diff --git a/string-list.h b/string-list.h
> index 7e51d03..84996aa 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -29,6 +29,15 @@ int for_each_string_list(struct string_list *list,
>  #define for_each_string_list_item(item,list) \
>  	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
>  
> +/*
> + * Apply fn to each item in list, retaining only the ones for which
> + * the function returns true.  If free_util is true, call free() on
> + * the util members of any items that have to be deleted.  Preserve
> + * the order of the items that are retained.
> + */
> +void filter_string_list(struct string_list *list, int free_util,
> +			string_list_each_func_t fn, void *cb_data);
> +
>  /* Use these functions only on sorted lists: */
>  int string_list_has_string(const struct string_list *list, const char *string);
>  int string_list_find_insert_index(const struct string_list *list, const char *string,

Having seen that the previous patch introduced a new test helper for
unit testing (which is a very good idea) and dedicated a new test
number, I would have expected to see a new test for filtering
here.
