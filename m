From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [RFC/PATCH] tag: add --points-at list option
Date: Sun, 5 Feb 2012 21:48:20 -0800
Message-ID: <20120206054819.GB10489@tgrennan-laptop>
References: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
 <7vvcnkeu2i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 06:48:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHRG-000450-6C
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427Ab2BFFs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 00:48:26 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43337 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab2BFFsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:48:25 -0500
Received: by vcge1 with SMTP id e1so3685092vcg.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 21:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Rs56Y+uOCT06Hj4wsNPWogwio6GROS0wfh8OsZAFVik=;
        b=QDkHUVRCg80NGt/XCLdINPxgic1DcK1hErGKGtCGngOR5n498Tvp/Q7AVCx+fo5XrA
         ii5g5ZlRg3b2kJD4sN4AUc67QWZ2HS/IzJJfA/8A76mswuJiy/qseqlEZNGZxLUM9X9F
         aJz55yddLcfMtEcvojT/qftguNvZxvDizn58c=
Received: by 10.220.152.146 with SMTP id g18mr9344751vcw.30.1328507305008;
        Sun, 05 Feb 2012 21:48:25 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id hm8sm9674775vdb.3.2012.02.05.21.48.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 21:48:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vvcnkeu2i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190023>

On Sun, Feb 05, 2012 at 03:31:17PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> @@ -105,16 +107,28 @@ static int show_reference(const char *refname, const unsigned char *sha1,
>>  				return 0;
>>  		}
>>  
>> +		buf = read_sha1_file(sha1, &type, &size);
>> +		if (!buf || !size)
>> +			return 0;
>> +
>> +		if (filter->points_at) {
>> +			unsigned char tagged_sha1[20];
>> +			if (memcmp("object ", buf, 7) \
>> +			    || buf[47] != '\n' \
>> +			    || get_sha1_hex(buf + 7, tagged_sha1) \
>> +			    || memcmp(filter->points_at, tagged_sha1, 20)) {
>
>Do we need these backslashes at the end of these lines?

No, just an old habit. Thanks.

>> @@ -143,16 +157,20 @@ static int show_reference(const char *refname, const unsigned char *sha1,
>>  }
>>  
>>  static int list_tags(const char **patterns, int lines,
>> -			struct commit_list *with_commit)
>> +			struct commit_list *with_commit,
>> +			unsigned char *points_at)
>>  {
>
>It strikes me somewhat odd that you can give a list of commits to filter
>when using "--contains" (e.g. "--contains v1.7.9 --contains 1.7.8.4"), but
>you can only ask for a single object with "--points-at" from the UI point
>of view.
>
>> @@ -375,12 +393,28 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
>>  	return check_refname_format(sb->buf, 0);
>>  }
>>  
>> +int parse_opt_points_at(const struct option *opt, const char *arg, int unset)
>> +{
>> +	unsigned char *sha1;
>> +
>> +	if (!arg)
>> +		return -1;
>> +	sha1 = xmalloc(20);
>> +	if (get_sha1(arg, sha1)) {
>> +		free(sha1);
>> +		return error("malformed object name %s", arg);
>> +	}
>> +	*(unsigned char **)opt->value = sha1;
>> +	return 0;
>> +}
>
>We are ignoring earlier --points-at argument without telling the user that
>we do not support more than one.
>
>Would it become too much unnecessary addition of new code if you supported
>multiple --points-at on the command line for the sake of consistency?

OK, I'll implement multiple args to be consistent with contains and patterns.

>> @@ -417,6 +451,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>  			PARSE_OPT_LASTARG_DEFAULT,
>>  			parse_opt_with_commit, (intptr_t)"HEAD",
>>  		},
>> +		{
>> +			OPTION_CALLBACK, 0, "points-at", &points_at, "object",
>> +			"print only annotated|signed tags of the object",
>> +			PARSE_OPT_LASTARG_DEFAULT,
>> +			parse_opt_points_at, (intptr_t)"HEAD",
>> +		},
>
>I wonder if defaulting to HEAD even makes sense for --points-at. When you
>are chasing a bug and checked out an old version that originally had
>problem, "git tag --contains" that defaults to HEAD does have a value. It
>tells us what releases are potentially contaminated with the buggy commit.
>
>But does a similar use case support points-at that defaults to HEAD?

Yes, the usage, "--points-at <object>..." implies that there is no
default. So, I suppose that NULL more appropriate than "HEAD".

Should I make the "contains" usage indicate that "commit" is optional
like this?
	"[--contains [<commit>...]] [--points-at <object>..]"

>Other than that, thanks for a pleasant read.

Thanks,
TomG
