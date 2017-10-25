Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA12F203F2
	for <e@80x24.org>; Wed, 25 Oct 2017 19:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbdJYT2G (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 15:28:06 -0400
Received: from siwi.pair.com ([209.68.5.199]:12678 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdJYT2E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 15:28:04 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 353BA84585;
        Wed, 25 Oct 2017 15:28:04 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C308D84584;
        Wed, 25 Oct 2017 15:28:03 -0400 (EDT)
Subject: Re: [PATCH 07/13] list-objects-filter-options: common argument
 parsing
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
 <20171024185332.57261-8-git@jeffhostetler.com>
 <CAGf8dgJmwtN-v9SQfjUJOBreGQ==iM1G-oGBh3oYH_DE4NYyLA@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a262e30b-1221-17b2-54dc-ccb6c710391f@jeffhostetler.com>
Date:   Wed, 25 Oct 2017 15:28:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGf8dgJmwtN-v9SQfjUJOBreGQ==iM1G-oGBh3oYH_DE4NYyLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2017 12:14 AM, Jonathan Tan wrote:
> On Tue, Oct 24, 2017 at 11:53 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>> + * <arg> ::= blob:none
>> + *           blob:limit:<n>[kmg]
>> + *           sparse:oid:<oid-expression>
>> + *           sparse:path:<pathname>
> 
> I notice in the code below that there are some usages of "=" instead
> of ":" - could you clarify which one it is? (Ideally this would point
> to one point of documentation which serves as both user and technical
> documentation.)

good catch.  thanks!
  
>> + */
>> +int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
>> +                             const char *arg)
>> +{
>> +       struct object_context oc;
>> +       struct object_id sparse_oid;
>> +       const char *v0;
>> +       const char *v1;
>> +
>> +       if (filter_options->choice)
>> +               die(_("multiple object filter types cannot be combined"));
>> +
>> +       /*
>> +        * TODO consider rejecting 'arg' if it contains any
>> +        * TODO injection characters (since we might send this
>> +        * TODO to a sub-command or to the server and we don't
>> +        * TODO want to deal with legacy quoting/escaping for
>> +        * TODO a new feature).
>> +        */
>> +
>> +       filter_options->raw_value = strdup(arg);
>> +
>> +       if (skip_prefix(arg, "blob:", &v0) || skip_prefix(arg, "blobs:", &v0)) {
> 
> I know that some people prefer leniency, but I think it's better to
> standardize on one form ("blob" instead of both "blob" and "blobs").

I could go either way on this.  (I kept mistyping it during interactive testing,
so I added both cases...)

> 
>> +               if (!strcmp(v0, "none")) {
>> +                       filter_options->choice = LOFC_BLOB_NONE;
>> +                       return 0;
>> +               }
>> +
>> +               if (skip_prefix(v0, "limit=", &v1) &&
>> +                   git_parse_ulong(v1, &filter_options->blob_limit_value)) {
>> +                       filter_options->choice = LOFC_BLOB_LIMIT;
>> +                       return 0;
>> +               }
>> +       }
>> +       else if (skip_prefix(arg, "sparse:", &v0)) {
>> +               if (skip_prefix(v0, "oid=", &v1)) {
>> +                       filter_options->choice = LOFC_SPARSE_OID;
>> +                       if (!get_oid_with_context(v1, GET_OID_BLOB,
>> +                                                 &sparse_oid, &oc)) {
>> +                               /*
>> +                                * We successfully converted the <oid-expr>
>> +                                * into an actual OID.  Rewrite the raw_value
>> +                                * in canonoical form with just the OID.
>> +                                * (If we send this request to the server, we
>> +                                * want an absolute expression rather than a
>> +                                * local-ref-relative expression.)
>> +                                */
>> +                               free((char *)filter_options->raw_value);
>> +                               filter_options->raw_value =
>> +                                       xstrfmt("sparse:oid=%s",
>> +                                               oid_to_hex(&sparse_oid));
>> +                               filter_options->sparse_oid_value =
>> +                                       oiddup(&sparse_oid);
>> +                       } else {
>> +                               /*
>> +                                * We could not turn the <oid-expr> into an
>> +                                * OID.  Leave the raw_value as is in case
>> +                                * the server can parse it.  (It may refer to
>> +                                * a branch, commit, or blob we don't have.)
>> +                                */
>> +                       }
>> +                       return 0;
>> +               }
>> +
>> +               if (skip_prefix(v0, "path=", &v1)) {
>> +                       filter_options->choice = LOFC_SPARSE_PATH;
>> +                       filter_options->sparse_path_value = strdup(v1);
>> +                       return 0;
>> +               }
>> +       }
>> +
>> +       die(_("invalid filter expression '%s'"), arg);
>> +       return 0;
>> +}
>> +
>> +int opt_parse_list_objects_filter(const struct option *opt,
>> +                                 const char *arg, int unset)
>> +{
>> +       struct list_objects_filter_options *filter_options = opt->value;
>> +
>> +       assert(arg);
>> +       assert(!unset);
>> +
>> +       return parse_list_objects_filter(filter_options, arg);
>> +}
>> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
>> new file mode 100644
>> index 0000000..23bd68e
>> --- /dev/null
>> +++ b/list-objects-filter-options.h
>> @@ -0,0 +1,50 @@
>> +#ifndef LIST_OBJECTS_FILTER_OPTIONS_H
>> +#define LIST_OBJECTS_FILTER_OPTIONS_H
>> +
>> +#include "parse-options.h"
>> +
>> +/*
>> + * Common declarations and utilities for filtering objects (such as omitting
>> + * large blobs) in list_objects:traverse_commit_list() and git-rev-list.
>> + */
>> +
>> +enum list_objects_filter_choice {
>> +       LOFC_DISABLED = 0,
>> +       LOFC_BLOB_NONE,
>> +       LOFC_BLOB_LIMIT,
>> +       LOFC_SPARSE_OID,
>> +       LOFC_SPARSE_PATH,
>> +};
>> +
>> +struct list_objects_filter_options {
>> +       /*
>> +        * The raw argument value given on the command line or
>> +        * protocol request.  (The part after the "--keyword=".)
>> +        */
>> +       char *raw_value;
>> +
>> +       /*
>> +        * Parsed values. Only 1 will be set depending on the flags below.
>> +        */
>> +       struct object_id *sparse_oid_value;
>> +       char *sparse_path_value;
>> +       unsigned long blob_limit_value;
>> +
>> +       enum list_objects_filter_choice choice;
>> +};
>> +
>> +/* Normalized command line arguments */
>> +#define CL_ARG__FILTER "filter"
>> +
>> +int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
>> +                             const char *arg);
>> +
>> +int opt_parse_list_objects_filter(const struct option *opt,
>> +                                 const char *arg, int unset);
>> +
>> +#define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
>> +       { OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
>> +         N_("object filtering"), PARSE_OPT_NONEG, \
>> +         opt_parse_list_objects_filter }
> 
> Thanks - this does make it easier to have a standard argument name and
> description everywhere.
> 
>> +
>> +#endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
>> --
>> 2.9.3
>>
