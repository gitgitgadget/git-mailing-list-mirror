From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 0/2] git-send-email: Message-ID caching
Date: Wed, 21 Aug 2013 19:04:20 +0000
Message-ID: <1377111862-13199-1-git-send-email-rv@rasmusvillemoes.dk>
References: <1376701126-5759-1-git-send-email-rv@rasmusvillemoes.dk>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: gitster@pobox.com, sandals@crustytoothpaste.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 21:04:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCDiC-0001bZ-7L
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 21:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab3HUTEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 15:04:52 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:39506 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab3HUTEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 15:04:51 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so464220eaj.39
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 12:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aTPN86mdBsXZS8kdwB++CTJ6Pw2liyp4BsDn9kmHeQE=;
        b=ICh4mfUZdGstk5ApnzdV3+UjIcGkguQSDZWLWJZtV2mtxCpK+QP4hc9cMqTPp7TGMa
         xOfyomE2IefobFx4mgDeVIEFjxQF90lR1NLyhwDK83mMrlh1dqPS2RiKTB2GycPBdVPP
         zCQ+MLwECxGWMrm5qBWJNXTavMczXu8gR4Nh+PhLl5w7xWBLNecTVMnsk1BtNTzWqb+b
         Tpo4lR8o5SkQ9EZlCIPuo9lJTHvW+fUkynVnTlbqK8jr4bcTcr7SRjnSXXt1alcEaeJ+
         Yj2azoknDMy8GytXu3ckBWUS0Gyb3jbXepIHZm5fxgEQbQg9IqSMsjG31L55l7Wn6sZZ
         V97g==
X-Gm-Message-State: ALoCoQnBGJgG8B1eNhn/RdYA5gMAawUFwL1elTxN42pL040VSiTzXLVGYuyc35ypZXAuguXHTMK7
X-Received: by 10.14.194.9 with SMTP id l9mr299811een.87.1377111890183;
        Wed, 21 Aug 2013 12:04:50 -0700 (PDT)
Received: from villemoes-sl500.decode.is (wildmoose.dk. [83.169.18.19])
        by mx.google.com with ESMTPSA id b45sm11933719eef.4.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 12:04:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.2.g61bff3f
In-Reply-To: <1376701126-5759-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232715>

This is a more polished attempt at implementing the message-id
caching. I apologize for the sloppiness (unrelated changes, unused
variables etc.) in the first version.

I have split the patch in two. The first half moves the choice-logic
inside ask(): If ask() decides to return the default immediately
(because the $term->{IN,OUT} checks fail), there's no reason to print
all the choices. In my first attempt, I handled this by passing a huge
prompt-string, but that made everything underlined (the prompt may be
emphasized in some other way on other terminals). Passing a different
valid_re and handling a numeric return is also slightly more
cumbersome for the caller than making ask() take care of it. There
might be other future uses of this 'choices' ability, but if the
message-id-caching is ultimately rejected, [1/2] can of course also be
dropped.

[2/2] is the new implementation. The two main changes are that old
entries are expunged when the file grows larger than, by default, 100
kB, and the old emails are scored according to a simple scheme (which
might need improvement). The input to the scoring is {first subject in
new batch, old subject, was the old email first in a batch?}. [*]

I also now simply store the unix time stamp instead of storing the
contents of the date header. This reduces processing time (no need to
parse the date header when reading the file), and eliminates the
Date::Parse dependency. The minor downside is that if the user has
changed time zone since the old email was sent, the date in the prompt
will not entirely match the Date:-header in the email that was sent.

I had to rearrange the existing code a little to make certain global
variables ($time, @files) contain the right thing at the right time,
but hopefully I haven't broken anything in the process.

[*] Suggestions for improving that heuristic are welcome. One thing
that might be worthwhile is to give words ending in a colon higher
weight.

Rasmus Villemoes (2):
  git-send-email: add optional 'choices' parameter to the ask sub
  git-send-email: Cache generated message-ids, use them when prompting

 git-send-email.perl |  144 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 6 deletions(-)


Thanks, Junio, for the comments. A few replies:

Junio C Hamano <gitster@pobox.com> writes:

> Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:
>>  my %config_path_settings = (
>> @@ -311,6 +314,7 @@ my $rc = GetOptions("h" => \$help,
>>  		    "8bit-encoding=s" => \$auto_8bit_encoding,
>>  		    "compose-encoding=s" => \$compose_encoding,
>>  		    "force" => \$force,
>> +		    "msgid-cache-file=s" => \$msgid_cache_file,
>>  	 );
>
> Is there a standard, recommended location we suggest users to store
> this?  

I don't know. It is obviously a local, per-repository, thing. I don't
know enough about git's internals to know if something breaks if one
puts it in .git (say, ".git/msgid.cache"). If that's a bad idea, then
I think it should be in the root of the repository, and one would then
probably want to add it to .git/info/exclude.

If storing it under .git is possible, one could consider making the
option a boolean ('msgid-use-cache' ?) and always use
".git/msgid.cache".

>> +	my @choices;
>> +	if ($msgid_cache_file) {
>> +		@choices = msgid_cache_getmatches();
>
> It is a bit strange that "filename is specified => we will find the
> latest 10" before seeing if we even check to see if that file
> exists.  I would have expected that a two-step "filename is given =>
> try to read it" and "if we did read something => give choices"
> process would be used.

I'm not sure I understand how this is different from what I was or am
doing. Sure, I don't do the test for existence before calling
msgid_cache_getmatches(), but that will just return an empty list if
the file does not exist. That will end up doing the same thing as if
no cache file was given.

> Also "getmatches" that does not take any clue from what the caller
> knows (the title of the series, for example) seems much less useful
> than ideal.

Fixed in the new version.

>> +	msgid_cache_this($message_id, $subject, $date) if ($msgid_cache_file && !$dry_run);
>
> Is this caching each and every one, even for things like "[PATCH 23/47]"?

Yes, but now I remember whether it was the first or not. 

>> +msgid_cache_write() if $msgid_cache_file;
>
> Is this done under --dry-run?

Well, it was, but the msgid_cache_this() was not, so there was an
empty list of new entries. Of course, better to be explicit and safe,
so fixed.

>> +	if (not open ($fh, '<', $msgid_cache_file)) {
>> +		# A non-existing cache file is ok, but should we warn if errno != ENOENT?
>
> It should not be a warning but an informational message, "creating a
> new cachefile", when bootstrapping, no?

If so, it should probably be when writing the new file. What I'm
trying to say is that errno == ENOENT is ok (and expected), but errno
== EPERM or anything else might be a condition we should warn or even
die on.

>> +	while ($line = <$fh>) {
>> +		chomp($line);
>> +		my ($id, $date, $subject) = split /\t/, $line;
>> +		my $epoch = str2time($date);
>> +		push @entries, {id=>$id, date=>$date, epoch=>$epoch, subject=>$subject};
>> +	}
>> +	close($fh);
>> +	return @entries;
>
> So all the old ones are read, without dropping ancient and possibly
> useless ones here...
>
>> +sub msgid_cache_write {
>> +	my $fh;
>> +	if (not open($fh, '>>', $msgid_cache_file)) {
>> +	    warn "cannot open $msgid_cache_file for appending: $!";
>> +	    return;
>> +	}
>> +	printf $fh "%s\t%s\t%s\n", $_->{id}, $_->{date}, $_->{subject} for (@msgid_new_entries);
>> +	close($fh);
>
> And the new ones are appended to the end without expiring anything.
>
> When does the cache shrink, and who is responsible for doing so?

Fixed. Whether it should be "cap when larger than $size" or "remove
entries older than time()-$maxage" I don't know.

> The //= operator is mentioned in perl581delta.pod, it seems, and
> none of our Perl scripted Porcelains seems to use it yet.  Is it
> safe to assume that everybody has it?

No, fixed.

>> +	if ($subject) {
>> +		$subject =~ s/^\s+|\s+$//g;
>> +		$subject =~ s/\s+/ /g;
>> +	}
>> +	# Replace undef or the empty string by an actual string. Nobody uses "0" as the subject...
>
> That's a strange sloppiness for somebody who uses //=, no?

Fixed.


-- 
1.7.9.5
