From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Fri, 6 Jun 2014 17:29:01 +0200
Message-ID: <CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.89933.chriscool@tuxfamily.org>
	<xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 17:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsw4r-0002vk-Nz
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 17:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbaFFP3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 11:29:04 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43346 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbaFFP3C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 11:29:02 -0400
Received: by mail-vc0-f174.google.com with SMTP id ik5so3168471vcb.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GZu/zZ1DyhrLqREDQD6gKa4j3+ra3NjkDs7U9k91aQQ=;
        b=j5VDmjCWCEllIlZMweEweJoYQIjcGF5wW/thYb0uOHauUXof/dQ7dRMO9fNSE3j0Xq
         my397QmDHcRiWfhWB4A7Ij2FY+5xl5T91iDhkoZBUxF27uR+liPx4rV7coeR9zVX7cgt
         QedaOrU76zVlBeWan/bsbW1XOm5e/AL1SdY/XYzwt6PadYvyjQmamlJrIQvT/a9Rr4Ma
         teFR3ydb+7Jf193iW433rJKXVMq/nodRy0m4MTSw684qDXAQsN8YG3rb5r0Ryt5+ir8a
         Y/ugG/0xb/9+hse+C9HZGtNW2rHxlQgY/DBmLXm6eHOVFKL5+V3125zUU31ITnn1iU+l
         Vhig==
X-Received: by 10.58.132.41 with SMTP id or9mr6378363veb.5.1402068541743; Fri,
 06 Jun 2014 08:29:01 -0700 (PDT)
Received: by 10.58.134.107 with HTTP; Fri, 6 Jun 2014 08:29:01 -0700 (PDT)
In-Reply-To: <xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250941>

On Thu, Jun 5, 2014 at 11:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> +static int create_graft(int argc, const char **argv, int force)
>> +{
>> +     unsigned char old[20], new[20];
>> +     const char *old_ref = argv[0];
>> +     struct commit *commit;
>> +     struct strbuf buf = STRBUF_INIT;
>> +     struct strbuf new_parents = STRBUF_INIT;
>> +     const char *parent_start, *parent_end;
>> +     int i;
>> +
>> +     if (get_sha1(old_ref, old) < 0)
>> +             die(_("Not a valid object name: '%s'"), old_ref);
>> +     commit = lookup_commit_or_die(old, old_ref);
>
> Not a problem with this patch, but the above sequence somehow makes
> me wonder if lookup-commit-or-die is a good API for this sort of
> thing.  Wouldn't it be more natural if it took not "unsigned char
> old[20]" but anything that would be understood by get_sha1()?
>
> It could be that this particular caller is peculiar and all the
> existing callers are happy, though.  I didn't "git grep" to spot
> patterns in existing callers.

lookup_commit_or_die() looked like a good API to me because I saw that
it checked a lot of things and die in case of problems, which could
make the patch shorter.

>> +     if (read_sha1_commit(old, &buf))
>> +             die(_("Invalid commit: '%s'"), old_ref);
>> +     /* make sure the commit is not corrupt */
>> +     if (parse_commit_buffer(commit, buf.buf, buf.len))
>> +             die(_("Could not parse commit: '%s'"), old_ref);
>
> It is unclear to me what you are trying to achieve with these two.
> If the earlier lookup-commit has returned a commit object that has
> already been parsed, parse_commit_buffer() would not check anything,
> would it?

Yeah, you are right. I missed the fact that lookup_commit_or_die()
calls parse_object() which itself calls read_sha1_file() and then
parse_object_buffer() which calls parse_commit_buffer().

Here is a backtrace that shows this:

#0  parse_commit_buffer (item=0x8597b0, buffer=0x851730, size=228) at
commit.c:251
#1  0x00000000004fa215 in parse_object_buffer (sha1=0x7fffffffdbf0
"\t>A\247\235J\213\376<u\212\226\311^[\371\343^\330\234",
type=OBJ_COMMIT, size=228,
    buffer=0x851730, eaten_p=0x7fffffffdacc) at object.c:198
#2  0x00000000004fa50a in parse_object (sha1=0x7fffffffdbf0
"\t>A\247\235J\213\376<u\212\226\311^[\371\343^\330\234") at
object.c:264
#3  0x00000000004a89ef in lookup_commit_reference_gently
(sha1=0x7fffffffdbf0
"\t>A\247\235J\213\376<u\212\226\311^[\371\343^\330\234", quiet=0) at
commit.c:38
#4  0x00000000004a8a48 in lookup_commit_reference (sha1=0x7fffffffdbf0
"\t>A\247\235J\213\376<u\212\226\311^[\371\343^\330\234") at
commit.c:47
#5  0x00000000004a8a67 in lookup_commit_or_die (sha1=0x7fffffffdbf0
"\t>A\247\235J\213\376<u\212\226\311^[\371\343^\330\234",
    ref_name=0x7fffffffe465
"093e41a79d4a8bfe3c758a96c95e5bf9e35ed89c") at commit.c:52
#6  0x000000000047f89a in create_graft (argc=1, argv=0x7fffffffe130,
refdir=0x0, force=0) at builtin/replace.c:353
#7  0x000000000047ff71 in cmd_replace (argc=1, argv=0x7fffffffe130,
prefix=0x0) at builtin/replace.c:461
#8  0x0000000000405441 in run_builtin (p=0x7eee90, argc=3,
argv=0x7fffffffe130) at git.c:314
#9  0x000000000040563a in handle_builtin (argc=3, argv=0x7fffffffe130)
at git.c:487
#10 0x0000000000405754 in run_argv (argcp=0x7fffffffe01c,
argv=0x7fffffffe020) at git.c:533
#11 0x00000000004058f9 in main (argc=3, av=0x7fffffffe128) at git.c:616

> A typical sequence would look more like this:
>
>     commit = lookup_commit(...);
>     if (parse_commit(commit))
>         oops there is an error;
>     /* otherwise */
>     use(commit->buffer);
>
> without reading a commit object using low-level read-sha1-file
> interface yourself, no?

Yeah, or I could just rely on the fact that lookup_commit_or_die()
already parses the commit, with something like this:

      if (get_sha1(old_ref, old) < 0)
              die(_("Not a valid object name: '%s'"), old_ref);

      /* parse the commit buffer to make sure the commit is not corrupt */
      commit = lookup_commit_or_die(old, old_ref);

      /* find existing parents */
      parent_start = buf.buf;
      parent_start += 46; /* "tree " + "hex sha1" + "\n" */
      parent_end = parent_start;
...

Thanks,
Christian.
