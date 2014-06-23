From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 1/3] string-list: add string_list initialiser helper
 functions
Date: Mon, 23 Jun 2014 14:36:21 +0200
Message-ID: <53A81F45.70802@web.de>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com> <1403518300-23053-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 14:36:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz3UU-0000kQ-Mw
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 14:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbaFWMgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 08:36:51 -0400
Received: from mout.web.de ([212.227.15.4]:59000 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbaFWMgu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 08:36:50 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MHdwC-1WxwUV2vDI-003OzY; Mon, 23 Jun 2014 14:36:47
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1403518300-23053-2-git-send-email-tanayabh@gmail.com>
X-Provags-ID: V03:K0:mh6uozQh+cn7MbqvTnxZoqlGkqyRx0nYd3jjxxnrI+Yj85d2FrS
 5QRXrDB551Js5mQrLg5xH6gT1MIugHdKt7C49LHGA/EOE5Apcst+MyFxxnptLPyLIRhWKVt
 1imZCl9XX8ohY18xIu+V/YmfPoS94xrDQLziuu5ZPLKFlYvqdb/5xCGsOF7mwbaLlEr7OeG
 42ApMxrQH71yd2H5OvWQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252344>

On 2014-06-23 12.11, Tanay Abhra wrote:
> The string-list API has STRING_LIST_INIT_* macros to be used
> to define variables with initialisers, but lacks functions
> to initialise an uninitialised piece of memory to be used as
> a string-list at the run-time.
> Introduce string_list_init_{dup,nodup}() functions for that.
> 
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  string-list.c | 18 ++++++++++++++++++
>  string-list.h |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/string-list.c b/string-list.c
> index aabb25e..8c3a4eb 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -1,6 +1,24 @@
>  #include "cache.h"
>  #include "string-list.h"
>  
> +void string_list_init_nodup(struct string_list *list)
> +{
> +	list->items = NULL;
> +	list->nr = 0;
> +	list->alloc = 0;
> +	list->strdup_strings = 0;
> +	list->cmp = NULL;
> +}
> +
If we look at the definition below:
struct string_list {
	struct string_list_item *items;
	unsigned int nr, alloc;
	unsigned int strdup_strings:1;
	compare_strings_fn cmp; /* NULL uses strcmp() */
I think a simple memset() will be easier to read,
and it will be more future proof:
In case elements are added, the will have 0 or NULL automatically:

void string_list_init_nodup(struct string_list *list)
{
	memset (list, 0, sizeof(*list));
}
(But then I wonder if we need the function at all ?)

Or does it make sense to have a common function similar to this,
which covers both cases:

void string_list_init(struct string_list *list, int strdup_strings)
{
	memset (list, 0, sizeof(*list));
	list->strdup_strings = strdup_strings;
}
