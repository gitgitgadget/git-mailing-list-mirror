From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Mon, 26 Aug 2013 13:19:50 -0400
Message-ID: <CABURp0oTsyG-FCgAzYZjtwwP_VMudV0=_Z5eOe+qbhPbmPqx4g@mail.gmail.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
 <CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
 <xmqqa9k6moif.fsf@gitster.dls.corp.google.com> <20130825042314.GE2882@elie.Belkin>
 <xmqqk3jal4t7.fsf@gitster.dls.corp.google.com> <xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
 <CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com>
 <xmqqr4dgifp5.fsf@gitster.dls.corp.google.com> <xmqqioysidu1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:20:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0Sg-0000Qd-Si
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab3HZRUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:20:12 -0400
Received: from mail-vb0-f41.google.com ([209.85.212.41]:50131 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab3HZRUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:20:11 -0400
Received: by mail-vb0-f41.google.com with SMTP id g17so2329519vbg.28
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bEqI5kUB5mqIkH5t4Mkm9cIAL6SIHjEJzL8ZxPS78Fc=;
        b=B7BnniE4skZZOvauQAUxD3nh3NzHLV/xxU07OizUy4b2hzusZkZHjlGk1ix4IirIIv
         JFFIqFsvw1mwvBIsQWY3NUlVBu6kU+wvy9yw1J9NDGCGcYo+OhTtg6qhGoKf8bTV0uyV
         Ct99DlfhDQTFFImiPEenkxdVM05DSk8CZw1X1tqpYJhYIQFhGJZmJvFHyrAbDfcIjLPY
         /VUT+uFWcr60wi8cpdP7CCJ53gN/f5EO5viXyZTBe5q8M0iEvqaQLGXX1k/gWv7rSwv3
         B7SOnjDZSK3KH6T7dJLh9dtscTjfHlptBQ9a5b/jhz70XNI33Vyj6R6DxL5iSnvsQZX5
         bIow==
X-Received: by 10.52.92.15 with SMTP id ci15mr956890vdb.34.1377537610265; Mon,
 26 Aug 2013 10:20:10 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Mon, 26 Aug 2013 10:19:50 -0700 (PDT)
In-Reply-To: <xmqqioysidu1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233007>

On Mon, Aug 26, 2013 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> If your justification were "above says 'there may be a readon why
>> the user wanted to ask it in that way', i.e. 'find in this tree
>> object HEAD:some/path and report where hits appear', but the reason
>> can only be from laziness and/or broken script and the user always
>> wants the answer from within the top-level tree-ish", then that
>> argument may make some sense. You need to justify why it is OK to
>> lose information in the answer by rewriting the colon that separates
>> the question ("in this tree object") and the answer ("at this path
>> relative to the tree object given").
>>
>> Whether you rewrite the input or the output is not important; you
>> are trying to give an answer to a different question, which is what
>> I find questionable.
>
> For example, one of the cases the proposed change will break that I
> am worried about is a script that wants to take N trees and a
> pattern, and report where in the given trees hits appear, something
> like:
>
> git grep -c -e $pattern "$@" |
> perl -e '
>         my @trees = @ARGV;
>         my %found = ();
>         while (<>) {
>                 my $line = $_;
>                 for (@trees) {
>                         my $tree_prefix = $_ . ":";
>                         my $len = len($tree_prefix);
>                         if (substr($line, 0, $len) eq $tree_prefix) {
>                                 my ($path_count) = substr($line, $len);
>                                 my ($path, $count) = $path_count =~ /^(.*):(\d+)$/
>                                 $found{$tree} = [$path, $count];
>                         }
>                 }
>         }
>         # Do stats on %found
> ' "$@"
>

I do understand there is potential breakage when a script is parsing
the output.  I did not consider that this was a feature someone may
want; it really only looks like a breakage to me, for the reasons I've
already given.

It's surprising just how broken it looks to me (given that I now know
it is not) since all the other filenames output from 'git-grep -l' are
valid filenames or object references.  There is only this one
tree-path instance which does not.  I suppose I will learn to live
with it.
