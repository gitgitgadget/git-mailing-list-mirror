From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 10:05:39 -0500
Message-ID: <CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
	<1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0ke-Ns0JCt6LAzWqympWZ=2x3rRHOjnzB9QN7gc2=ckgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 17:05:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue5BC-0005RF-37
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 17:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab3ESPFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 11:05:42 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:57468 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab3ESPFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 11:05:41 -0400
Received: by mail-lb0-f181.google.com with SMTP id w20so5367728lbh.40
        for <git@vger.kernel.org>; Sun, 19 May 2013 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=X6cKhgqKzunBmrOcFG6j6Q+u1FPCAD3T07vZY2qwYSk=;
        b=E3n+zDeHtOnDCJ0OMls1q7akFiyjovZ9k7oCTPUhxCx+5jXbsrdR2ERk1A7PUZLGfj
         LWTlRm0hOS+Of+bfhavRfIZpDKwJhpC2iqs3KtiZQt8uIY2jEdwvNlvs3S4QSAm7vYgf
         sQk1v8c+cdyni/oD+xSZlZHGtKFxWUbfwUD6LvEQM7eRQTCvlbCITFQWTjzrbI/z5kJX
         82GiSi+SPJbke5Gn1mqFt5jg4KLwm7Z0+76nQTmfcrvHgA1+fIbHz173W7PRioREub7U
         OMYHK+vnspDP5GtGfcqbSmRUc0ivUuzk1IVwLCEu0DqSaFbIvAGwZeQRyMYvTYTEJ6Ea
         eSdg==
X-Received: by 10.112.63.169 with SMTP id h9mr11247111lbs.135.1368975939638;
 Sun, 19 May 2013 08:05:39 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 08:05:39 -0700 (PDT)
In-Reply-To: <CALkWK0ke-Ns0JCt6LAzWqympWZ=2x3rRHOjnzB9QN7gc2=ckgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224889>

On Sun, May 19, 2013 at 9:40 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Okay, let's look at this part.
>
> Felipe Contreras wrote:
>> diff --git a/contrib/related/git-related b/contrib/related/git-related
>> new file mode 100755
>> index 0000000..4f31482
>> --- /dev/null
>> +++ b/contrib/related/git-related
>> @@ -0,0 +1,124 @@
>> +#!/usr/bin/env ruby
>> +
>> +# This script finds people that might be interested in a patch
>> +# usage: git related <file>
>> +
>> +$since = '5-years-ago'
>> +$min_percent = 10
>> +
>> +def fmt_person(name, email)
>> +  name ? '%s <%s>' % [name, email] : email
>> +end
>> +
>> +class Commit
>> +
>> +  attr_reader :persons
>> +
>> +  def initialize(id)
>> +    @id = id
>> +    @persons = []
>> +  end
>
> Okay, although I'm wondering what id is.

The commit's unique identifier. How is that not clear?

>> +  def parse(data)
>> +    msg = nil
>> +    data.each_line do |line|
>> +      if not msg
>> +        case line
>> +        when /^author ([^<>]+) <(\S+)> (.+)$/
>> +          @persons << fmt_person($1, $2)
>> +        when /^$/
>> +          msg = true
>> +        end
>
> When there's a blank line, flip the switch and start looking in the
> commit message.  Why though?  You're worried that the commit message
> will contain a line matching /^author ([^<>]+) <(\S+)> (.+)$/?  If so,
> why don't you split('\n', 2), look for the author in the $1 and
> Whatevered-by in $2?

That's not efficient, it's more efficient to parse line by line
lazily, and it's not that complicated.

>> +      else
>> +        if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
>
> elif?

It will get bigger soon enough.

> Can this be more generic to include Whatevered-by?

That's done in later patches. This is a minimal version.

>> +          @persons << fmt_person($2, $3)
>
> Will $2 ever be nil (from fmt_person)?  ie. Why are you checking for
> the special case " <\S+?>$"?

Yes, '<email>' was valid in earlier versions of git.

>> +        end
>> +      end
>> +    end
>> +    @persons.uniq!
>
> So you don't care if the person has appeared twice or thrice in the message.

Yes I do, otherwise they be counted multiple times, and their
participation calculation would go beyond 100%.

>> +  def size
>> +    @items.size
>> +  end
>
> #size is reminiscent of Array#size and Hash#size.

Precisely. I would even include Array if it made sense.

>> +  def each(&block)
>> +    @items.each(&block)
>> +  end
>
> I can see how you iterate over commits from the code below.  However,
> using #each like this is confusing, because the reader expects #each
> to be invoked on an Enumerable.  So, I have two suggestions:

We can include Enumerable, it won't make a difference.

> 1. Use block_given? to make sure that #each works even without a block
> (just like Enumerator#each).

It already works just like Enumerator#each; commits.each returns an
Enumerator because @items.each returns an Enumerator.

> 2. Mixin Enumerable by putting in an 'include Enumerable' after the
> class line.  Aside from clarity, you get stuff like #find for free.

Stuff we don't need or want.

>> +  def import
>
> From reading the code below, your calling semantics are: first set
> each @items[id] to a new Commit object.  import is meant to invoke
> Commit#parse and set @persons there.  Okay.
>
>> +    return if @items.empty?
>> +    File.popen(%w[git cat-file --batch], 'r+') do |p|
>> +      p.write(@items.keys.join("\n"))
>> +      p.close_write
>
> Okay.
>
>> +      p.each do |l|
>> +        if l =~ /^(\h{40}) commit (\d+)/
>
> s/l/line/?

Fine.

>> +          id, len = $1, $2
>> +          data = p.read($2.to_i)
>> +          @items[id].parse(data)
>> +        end
>> +      end
>> +    end
>> +  end
>> +
>> +  def get_blame(source, start, len, from)
>> +    return if len == 0
>> +    len ||= 1
>
> Please don't use ||=.  It is notorious for causing confusion in
> Ruby-land.  Hint: it's not exactly equivalent to either len = len || 1
> or len || len = 1.

How exactly is it not equivalent to len = len || 1?

This is what I want:

len = 1 if not len

And I think the above does exactly that.

>> +    File.popen(['git', 'blame', '--incremental', '-C',
>
> Still no -CCC?

I forgot.

>> +               '-L', '%u,+%u' % [start, len],
>> +               '--since', $since, from + '^',
>> +               '--', source]) do |p|
>> +      p.each do |line|
>> +        if line =~ /^(\h{40})/
>> +          id = $1
>
> Use $0 and remove the parens: you're matching the whole line.

No, I'm not matching the whole line, but you are right; there's no
need for groups.

>> +  end
>> +end
>> +
>> +count_per_person.each do |person, count|
>> +  percent = count.to_f * 100 / commits.size
>> +  next if percent < $min_percent
>> +  puts person
>
> Not going to print percentage as well?

Later. This does the minimum.

> Overall, significant improvement over v3 which used all kinds of
> unnecessarily complex data structures and convoluted logic.

It's coming.

-- 
Felipe Contreras
