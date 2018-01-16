Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6FA1F404
	for <e@80x24.org>; Tue, 16 Jan 2018 19:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeAPTAN (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 14:00:13 -0500
Received: from siwi.pair.com ([209.68.5.199]:21441 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeAPTAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 14:00:09 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 002BE84585;
        Tue, 16 Jan 2018 14:00:07 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 72A7084582;
        Tue, 16 Jan 2018 14:00:07 -0500 (EST)
Subject: Re: [PATCH] sha1_file: remove static strbuf from sha1_file_name()
To:     Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20180116071814.19884-1-chriscool@tuxfamily.org>
 <65c81aae-5652-281f-565a-f6116d94abc1@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b956f893-74c4-3b0e-1f0a-4be1b01dc649@jeffhostetler.com>
Date:   Tue, 16 Jan 2018 14:00:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <65c81aae-5652-281f-565a-f6116d94abc1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/16/2018 9:01 AM, Derrick Stolee wrote:
> On 1/16/2018 2:18 AM, Christian Couder wrote:
>> Using a static buffer in sha1_file_name() is error prone
>> and the performance improvements it gives are not needed
>> in most of the callers.
>>
>> So let's get rid of this static buffer and, if necessary
>> or helpful, let's use one in the caller.
> 
> First: this is a good change for preventing bugs in the future. Do not let my next thought deter you from making this change.
> 
> Second: I wonder if there is any perf hit now that we are allocating buffers much more often. Also, how often does get_object_directory() change, so in some cases we could cache the buffer and only append the parts for the loose object (and not reallocate because the filenames will have equal length).
> 
> I'm concerned about the perf implications when inspecting many loose objects (100k+) but these code paths seem to be involved with more substantial work, such as opening and parsing the objects, so keeping a buffer in-memory is probably unnecessary.
> 
>> ---
>>   cache.h       |  8 +++-----
>>   http-walker.c |  6 ++++--
>>   http.c        | 16 ++++++++++------
>>   sha1_file.c   | 38 +++++++++++++++++++++++++-------------
>>   4 files changed, 42 insertions(+), 26 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index d8b975a571..6db565408e 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -957,12 +957,10 @@ extern void check_repository_format(void);
>>   #define TYPE_CHANGED    0x0040
>>   /*
>> - * Return the name of the file in the local object database that would
>> - * be used to store a loose object with the specified sha1.  The
>> - * return value is a pointer to a statically allocated buffer that is
>> - * overwritten each time the function is called.
>> + * Put in `buf` the name of the file in the local object database that
>> + * would be used to store a loose object with the specified sha1.
>>    */
>> -extern const char *sha1_file_name(const unsigned char *sha1);
>> +extern void sha1_file_name(struct strbuf *buf, const unsigned char *sha1);
>>   /*
>>    * Return an abbreviated sha1 unique within this repository's object database.
>> diff --git a/http-walker.c b/http-walker.c
>> index 1ae8363de2..07c2b1af82 100644
>> --- a/http-walker.c
>> +++ b/http-walker.c
>> @@ -544,8 +544,10 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
>>       } else if (hashcmp(obj_req->sha1, req->real_sha1)) {
>>           ret = error("File %s has bad hash", hex);
>>       } else if (req->rename < 0) {
>> -        ret = error("unable to write sha1 filename %s",
>> -                sha1_file_name(req->sha1));
>> +        struct strbuf buf = STRBUF_INIT;
>> +        sha1_file_name(&buf, req->sha1);
>> +        ret = error("unable to write sha1 filename %s", buf.buf);
>> +        strbuf_release(&buf);
>>       }
>>       release_http_object_request(req);
>> diff --git a/http.c b/http.c
>> index 5977712712..5979305bc9 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -2168,7 +2168,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
>>       unsigned char *sha1)
>>   {
>>       char *hex = sha1_to_hex(sha1);
>> -    const char *filename;
>> +    struct strbuf filename = STRBUF_INIT;
>>       char prevfile[PATH_MAX];
>>       int prevlocal;
>>       char prev_buf[PREV_BUF_SIZE];
>> @@ -2180,14 +2180,15 @@ struct http_object_request *new_http_object_request(const char *base_url,
>>       hashcpy(freq->sha1, sha1);
>>       freq->localfile = -1;
>> -    filename = sha1_file_name(sha1);
>> +    sha1_file_name(&filename, sha1);
>>       snprintf(freq->tmpfile, sizeof(freq->tmpfile),
>> -         "%s.temp", filename);
>> +         "%s.temp", filename.buf);
>> -    snprintf(prevfile, sizeof(prevfile), "%s.prev", filename);
>> +    snprintf(prevfile, sizeof(prevfile), "%s.prev", filename.buf);
>>       unlink_or_warn(prevfile);
>>       rename(freq->tmpfile, prevfile);
>>       unlink_or_warn(freq->tmpfile);
>> +    strbuf_release(&filename);
>>       if (freq->localfile != -1)
>>           error("fd leakage in start: %d", freq->localfile);
>> @@ -2302,6 +2303,7 @@ void process_http_object_request(struct http_object_request *freq)
>>   int finish_http_object_request(struct http_object_request *freq)
>>   {
>>       struct stat st;
>> +    struct strbuf filename = STRBUF_INIT;
>>       close(freq->localfile);
>>       freq->localfile = -1;
>> @@ -2327,8 +2329,10 @@ int finish_http_object_request(struct http_object_request *freq)
>>           unlink_or_warn(freq->tmpfile);
>>           return -1;
>>       }
>> -    freq->rename =
>> -        finalize_object_file(freq->tmpfile, sha1_file_name(freq->sha1));
>> +
>> +    sha1_file_name(&filename, freq->sha1);
>> +    freq->rename = finalize_object_file(freq->tmpfile, filename.buf);
>> +    strbuf_release(&filename);
>>       return freq->rename;
>>   }
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 3da70ac650..f66c21b2da 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -321,15 +321,11 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
>>       }
>>   }
>> -const char *sha1_file_name(const unsigned char *sha1)
>> +void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
>>   {
>> -    static struct strbuf buf = STRBUF_INIT;
>> -
>> -    strbuf_reset(&buf);
>> -    strbuf_addf(&buf, "%s/", get_object_directory());
>> +    strbuf_addf(buf, "%s/", get_object_directory());
>> -    fill_sha1_path(&buf, sha1);
>> -    return buf.buf;
>> +    fill_sha1_path(buf, sha1);
>>   }
> 
> Could you change this to use strbuf_addstr(buf, get_object_directory()) followed by a strbuf_addch(buf, '/')? This format string is unnecessary and could become slow if this method is called in a tight loop.

Yes, an _addstr() and _addch() would avoid a sprintf and
we've seen perf problems with this before.

Could we also add seed the initial buffer size to avoid
any need to realloc as the buffer is filled in?

Something like:
	size_t len = strlen(get_object_directory()) + GIT_MAX_HEXSZ + 3;
	strbuf_reset(&buf);
	if (len > strbuf_avail(&buf))
		strbuf_grow(&buf, len);
	strbuf_addstr(&buf, ...);

> 
>>   struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
>> @@ -710,7 +706,12 @@ int check_and_freshen_file(const char *fn, int freshen)
>>   static int check_and_freshen_local(const unsigned char *sha1, int freshen)
>>   {
>> -    return check_and_freshen_file(sha1_file_name(sha1), freshen);
>> +    static struct strbuf buf = STRBUF_INIT;
>> +
>> +    strbuf_reset(&buf);
>> +    sha1_file_name(&buf, sha1);
>> +
>> +    return check_and_freshen_file(buf.buf, freshen);
>>   }

Does "buf" really need to be static here?  Doesn't this just move the problem
from sha1_file_name() to here?


>>   static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
>> @@ -866,8 +867,12 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
>>                 const char **path)
>>   {
>>       struct alternate_object_database *alt;
>> +    static struct strbuf buf = STRBUF_INIT;
>> +
>> +    strbuf_reset(&buf);
>> +    sha1_file_name(&buf, sha1);
>> +    *path = buf.buf;
>> -    *path = sha1_file_name(sha1);
>>       if (!lstat(*path, st))
>>           return 0;

Again, making "buf" static here feels wrong.  Perhaps, change the signature
of the static function to drop the const on the "path" and strbuf_detach buf.buf
and give it to the caller (if path is not NULL) and otherwise release it here.


>> @@ -891,8 +896,12 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
>>       int fd;
>>       struct alternate_object_database *alt;
>>       int most_interesting_errno;
>> +    static struct strbuf buf = STRBUF_INIT;
>> +
>> +    strbuf_reset(&buf);
>> +    sha1_file_name(&buf, sha1);
>> +    *path = buf.buf;
>> -    *path = sha1_file_name(sha1);
>>       fd = git_open(*path);
>>       if (fd >= 0)
>>           return fd;

Same comment here about the static strbuf.

  
> The check_and_freshen_nonlocal() and open_sha1_file() method comments warn about the 'path' pointer and how it could be overwritten with another call to sha1_file_name(). Your patch fixes that issue, so the comments can be removed.

Wait, we've eliminated the static buffer inside sha1_file_name(), but
all of these callers currently define their own static buffers, so the
comments still apply, right?

There is also an effectively static buffer in each of the alternates
that is used by alt_sha1_path().

  
> Since these methods are currently being extra careful about the 'path' parameter, perhaps these are candidates to keep a static buffer around?

If I have multiple threads (as part of say a threaded checkout), we're
still going to stumble over these static loose object pathname buffers,
right?


> 
>> @@ -1557,9 +1566,12 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
>>       git_SHA_CTX c;
>>       unsigned char parano_sha1[20];
>>       static struct strbuf tmp_file = STRBUF_INIT;
>> -    const char *filename = sha1_file_name(sha1);
>> +    static struct strbuf filename = STRBUF_INIT;
>> +
>> +    strbuf_reset(&filename);
>> +    sha1_file_name(&filename, sha1);
>> -    fd = create_tmpfile(&tmp_file, filename);
>> +    fd = create_tmpfile(&tmp_file, filename.buf);
>>       if (fd < 0) {
>>           if (errno == EACCES)
>>               return error("insufficient permission for adding an object to repository database %s", get_object_directory());
>> @@ -1612,7 +1624,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
>>               warning_errno("failed utime() on %s", tmp_file.buf);
>>       }
>> -    return finalize_object_file(tmp_file.buf, filename);
>> +    return finalize_object_file(tmp_file.buf, filename.buf);
>>   }
>>   static int freshen_loose_object(const unsigned char *sha1)
> 
> Thanks for this cleanup!
> -Stolee

Yes, thanks for digging into this!
Jeff

