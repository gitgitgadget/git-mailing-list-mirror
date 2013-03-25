From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/9] add test for streaming corrupt blobs
Date: Mon, 25 Mar 2013 17:26:05 -0400
Message-ID: <20130325212605.GA19303@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202134.GE16019@sigill.intra.peff.net>
 <20130325211038.GD1414@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:26:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKEuc-0004AU-02
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758678Ab3CYV0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:26:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39417 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758631Ab3CYV0J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:26:09 -0400
Received: (qmail 28568 invoked by uid 107); 25 Mar 2013 21:27:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 17:27:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 17:26:05 -0400
Content-Disposition: inline
In-Reply-To: <20130325211038.GD1414@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219092>

On Mon, Mar 25, 2013 at 02:10:38PM -0700, Jonathan Nieder wrote:

> > +# convert "1234abcd" to ".git/objects/12/34abcd"
> > +obj_to_file() {
> > +	echo "$(git rev-parse --git-dir)/objects/$(git rev-parse "$1" | sed 's,..,&/,')"
> > +}
> 
> Maybe this would be clearer in multiple lines?
> 
> 	commit=$(git rev-parse --verify "$1") &&
> 	git_dir=$(git rev-parse --git-dir) &&
> 	tail=${commit#??} &&
> 	echo "$git_dir/objects/${commit%$tail}/$tail"

Yeah, it started as:

  echo "$1" | sed 's,..,&/,'

and kind of got out of hand as it grew features. I'd be fine with your
version (though $commit is not right, as it is any object, and in fact
the test uses blobs).

> > +
> > +# Convert byte at offset "$2" of object "$1" into '\0'
> > +corrupt_byte() {
> > +	obj_file=$(obj_to_file "$1") &&
> > +	chmod +w "$obj_file" &&
> > +	printf '\0' | dd of="$obj_file" bs=1 seek="$2"
> 
> Some other tests such as t4205 also rely on "printf" being
> binary-safe.  Phew.

Yeah, I think it should be fine, though the choice of character does not
actually matter, as long as it is different from what is currently at
that position (for the sake of simplicity, I just determined
experimentally that the given object is corrupted with the offset and
character I chose).

-Peff
